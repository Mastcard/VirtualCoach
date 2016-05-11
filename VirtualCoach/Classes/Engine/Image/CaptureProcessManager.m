//
//  CaptureProcessManager.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 13/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CaptureProcessManager.h"

#import "ExtractorProcess.h"

@interface CaptureProcessManager ()

+ (void)startReferenceFrameProcess:(NSNotification *)notification;
+ (void)startTrackingProcess:(NSNotification *)notification;
+ (void)startRecordingProcess:(NSNotification *)notification;

+ (void)stopReferenceFrameProcess:(NSNotification *)notification;
+ (void)referenceFrameProcessDidFinish:(NSNotification *)notification;
+ (void)stopTrackingProcess:(NSNotification *)notification;
+ (void)stopRecordingProcess:(NSNotification *)notification;

@end

@implementation CaptureProcessManager

static HybridCaptureSessionController *captureSessionController;

static TrackingProcess *trackingProcess;
static ReferenceFrameProcess *referenceFrameProcess;
static RecordingProcess *recordingProcess;

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static CaptureProcessManager *sharedInstance = nil;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        trackingProcess = [[TrackingProcess alloc] init];
        referenceFrameProcess = [[ReferenceFrameProcess alloc] init];
        recordingProcess = [[RecordingProcess alloc] init];
        
        NSArray *devices = [AVCaptureDevice devices];
        
        AVCaptureDevice *camera = nil;
        
        for (AVCaptureDevice *device in devices)
            if ([device hasMediaType:AVMediaTypeVideo])
                if ([device position] == AVCaptureDevicePositionBack)
                    camera = device;
        
        if (!camera)
            NSLog(@"CaptureProcessManager : didn't find a device");
        
        captureSessionController = [CaptureSessionControllerFactory createHybridCaptureSessionControllerWithDevice:camera preset:AVCaptureSessionPreset1280x720 sampleBufferDelegate:referenceFrameProcess recordingDelegate:recordingProcess];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(startReferenceFrameProcess:)
                                                 name:@"referenceframe.action.started"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(startTrackingProcess:)
                                                 name:@"tracker.action.started"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(startRecordingProcess:)
                                                 name:@"recording.action.started"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(stopReferenceFrameProcess:)
                                                 name:@"referenceframe.action.stopped"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(referenceFrameProcessDidFinish:)
                                                 name:@"referenceframe.action.internal.finished"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(stopTrackingProcess:)
                                                 name:@"tracker.action.stopped"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self class]
                                             selector:@selector(stopRecordingProcess:)
                                                 name:@"recording.action.stopped"
                                               object:nil];
    
    return sharedInstance;
}

+ (void)startReferenceFrameProcess:(NSNotification *)notification
{
    //NSLog(@"startReferenceFrameProcess");
    
    gray8i_t *referenceFrame = [referenceFrameProcess retrieveReferenceFrame];
    
    if (referenceFrame != NULL)
        [referenceFrameProcess reset];
    
    [captureSessionController removeOutput];
    [captureSessionController addVideoDataOutput];
    
    [captureSessionController.captureSession.captureVideoDataOutput setSampleBufferDelegate:referenceFrameProcess queue:captureSessionController.captureSession.videoDataOutputQueue];
    [captureSessionController setSampleBufferDelegate:referenceFrameProcess];
    
    [captureSessionController startRetrievingFrames];
}

+ (void)startTrackingProcess:(NSNotification *)notification
{
    //NSLog(@"startTrackingProcess");
    
    gray8i_t *referenceFrame = [referenceFrameProcess retrieveReferenceFrame];
    
    if (referenceFrame != NULL)
        [trackingProcess setReferenceFrame:referenceFrame];
    
    [captureSessionController removeOutput];
    [captureSessionController addVideoDataOutput];
    
    [captureSessionController.captureSession.captureVideoDataOutput setSampleBufferDelegate:trackingProcess queue:captureSessionController.captureSession.videoDataOutputQueue];
    [captureSessionController setSampleBufferDelegate:trackingProcess];
    
    [captureSessionController startRetrievingFrames];
}

+ (void)startRecordingProcess:(NSNotification *)notification
{
    //NSLog(@"startRecordingProcess");
    
    NSDictionary *userInfo = notification.userInfo;
    
    [captureSessionController removeOutput];
    [captureSessionController addMovieFileOutput];
    
    [captureSessionController setRecordingDelegate:recordingProcess];
    
    [captureSessionController startRecordingMovieAtURL:(NSURL *)[userInfo objectForKey:@"video.path"]];
}

+ (void)stopReferenceFrameProcess:(NSNotification *)notification
{
    //NSLog(@"stopReferenceFrameProcess");
    [captureSessionController stopRetrievingFrames];
    [captureSessionController removeOutput];
    
}

+ (void)stopTrackingProcess:(NSNotification *)notification
{
    //NSLog(@"stopTrackingProcess");
    [captureSessionController stopRetrievingFrames];
    [captureSessionController removeOutput];
}

+ (void)stopRecordingProcess:(NSNotification *)notification
{
    //NSLog(@"stopRecordingProcess");
    [captureSessionController stopRecordingMovie];
    [captureSessionController removeOutput];
    
    // Save all informations of the video
    
    NSString *videoPath = recordingProcess.outputPath;
    
    gray8i_t *referenceFrame = trackingProcess.referenceFrame;
    
    uint8_t binaryThreshold = trackingProcess.binaryThreshold;
    
    rect_t lastPlayerBounds = trackingProcess.playerBounds;
    
    NSString *referenceFramePath = [[videoPath stringByDeletingPathExtension] stringByAppendingString:@"-reference.pgm"];
    
    pgmwrite(referenceFrame, [referenceFramePath cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
    
    NSString *dataFilePath = [[videoPath stringByDeletingPathExtension] stringByAppendingString:@"-data.plist"];
    
    NSDictionary *playerPositionDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithUnsignedInt:lastPlayerBounds.start.x], [NSNumber numberWithUnsignedInt:lastPlayerBounds.start.y], [NSNumber numberWithUnsignedInt:lastPlayerBounds.end.x], [NSNumber numberWithUnsignedInt:lastPlayerBounds.end.y], nil] forKeys:[NSArray arrayWithObjects:@"start.x", @"start.y", @"end.x", @"end.y", nil]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:videoPath, referenceFramePath, [NSNumber numberWithUnsignedChar:binaryThreshold], playerPositionDict, nil]
                                                     forKeys:[NSArray arrayWithObjects:@"videoPath", @"referenceFramePath", @"binaryThreshold", @"lastPlayerBounds", nil]];
    
    [dict writeToFile:dataFilePath atomically:YES];
}

+ (void)referenceFrameProcessDidFinish:(NSNotification *)notification
{
    [captureSessionController removeOutput];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.finished" object:self userInfo:nil];
}

- (HybridCaptureSessionController *)captureSessionController
{
    return captureSessionController;
}

- (TrackingProcess *)trackingProcess
{
    return trackingProcess;
}

- (ReferenceFrameProcess *)referenceFrameProcess
{
    return referenceFrameProcess;
}

- (RecordingProcess *)recordingProcess
{
    return recordingProcess;
}

@end
