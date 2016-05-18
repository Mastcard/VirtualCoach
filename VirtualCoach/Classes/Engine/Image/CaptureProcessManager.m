//
//  CaptureProcessManager.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 13/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CaptureProcessManager.h"

@interface CaptureProcessManager ()



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
    
    return sharedInstance;
}

+ (void)startReferenceFrameProcess
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

+ (void)startTrackingProcess
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

+ (void)startRecordingProcessAtPath:(NSURL *)path
{
    //NSLog(@"startRecordingProcess");
    
    [captureSessionController removeOutput];
    [captureSessionController addMovieFileOutput];
    
    [captureSessionController setRecordingDelegate:recordingProcess];
    
    [captureSessionController startRecordingMovieAtURL:path];
}

+ (void)stopReferenceFrameProcess
{
    //NSLog(@"stopReferenceFrameProcess");
    [captureSessionController stopRetrievingFrames];
    [captureSessionController removeOutput];
    
}

+ (void)stopTrackingProcess
{
    //NSLog(@"stopTrackingProcess");
    [captureSessionController stopRetrievingFrames];
    [captureSessionController removeOutput];
}

+ (void)stopRecordingProcess
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
    
    //temp
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lastInformationPath" object:self userInfo:[NSDictionary dictionaryWithObject:dataFilePath forKey:@"lastInformationPathKey"]];
}

//+ (void)referenceFrameProcessDidFinish
//{
//    [captureSessionController removeOutput];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.finished" object:[CaptureProcessManager sharedInstance] userInfo:nil];
//}

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
