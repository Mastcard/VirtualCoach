//
//  CaptureProcessManager.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 13/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CaptureProcessManager.h"

@interface CaptureProcessManager ()

+ (void)startReferenceFrameProcess:(NSNotification *)notification;
+ (void)startTrackingProcess:(NSNotification *)notification;
+ (void)startRecordingProcess:(NSNotification *)notification;

+ (void)stopReferenceFrameProcess:(NSNotification *)notification;
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
    NSLog(@"startReferenceFrameProcess");
    
    AVCaptureOutput *captureOutput = (AVCaptureOutput *)[captureSessionController.captureSession.captureSession.outputs objectAtIndex:0];
    
    if ([captureOutput isMemberOfClass:[AVCaptureMovieFileOutput class]])
        [captureSessionController switchCaptureOutput];
    
    [captureSessionController.captureSession.captureVideoDataOutput setSampleBufferDelegate:referenceFrameProcess queue:captureSessionController.captureSession.videoDataOutputQueue];
    [captureSessionController setSampleBufferDelegate:referenceFrameProcess];
    
    [captureSessionController startRetrievingFrames];
}

+ (void)startTrackingProcess:(NSNotification *)notification
{
    NSLog(@"startTrackingProcess");
    
    AVCaptureOutput *captureOutput = (AVCaptureOutput *)[captureSessionController.captureSession.captureSession.outputs objectAtIndex:0];
    
    if ([captureOutput isMemberOfClass:[AVCaptureMovieFileOutput class]])
        [captureSessionController switchCaptureOutput];
    
    [captureSessionController.captureSession.captureVideoDataOutput setSampleBufferDelegate:trackingProcess queue:captureSessionController.captureSession.videoDataOutputQueue];
    [captureSessionController setSampleBufferDelegate:trackingProcess];
    
    [captureSessionController startRetrievingFrames];
}

+ (void)startRecordingProcess:(NSNotification *)notification
{
    NSLog(@"startRecordingProcess");
    
    NSDictionary *userInfo = notification.userInfo;
    
    AVCaptureOutput *captureOutput = (AVCaptureOutput *)[captureSessionController.captureSession.captureSession.outputs objectAtIndex:0];
    
    if ([captureOutput isMemberOfClass:[AVCaptureVideoDataOutput class]])
        [captureSessionController switchCaptureOutput];
    
    [captureSessionController startRecordingMovieAtURL:[NSURL fileURLWithPath:[userInfo objectForKey:@"video.path"]]];
}

+ (void)stopReferenceFrameProcess:(NSNotification *)notification
{
    NSLog(@"stopReferenceFrameProcess");
    [captureSessionController stopRetrievingFrames];
}

+ (void)stopTrackingProcess:(NSNotification *)notification
{
    NSLog(@"stopTrackingProcess");
    [captureSessionController stopRetrievingFrames];
}

+ (void)stopRecordingProcess:(NSNotification *)notification
{
    NSLog(@"stopRecordingProcess");
    [captureSessionController stopRecordingMovie];
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
