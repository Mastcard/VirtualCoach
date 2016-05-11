//
//  FramesCaptureSessionController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "FramesCaptureSessionController.h"

@implementation FramesCaptureSessionController

@synthesize captureSession = _captureSession;

- (instancetype)initWithCaptureSession:(FramesCaptureSession *)captureSession
{
    self = [super initWithCaptureSession:captureSession];
    
    if (self)
    {
        _captureSession = captureSession;
    }
    
    return self;
}

- (void)setSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate,Process>)sampleBufferDelegate
{
    _sampleBufferDelegate = sampleBufferDelegate;
    
    [_captureSession.captureVideoDataOutput setSampleBufferDelegate:_sampleBufferDelegate queue:_captureSession.videoDataOutputQueue];
}

- (void)startRetrievingFrames
{
    [_sampleBufferDelegate start];
}

- (void)stopRetrievingFrames
{
    [_sampleBufferDelegate stop];
}

@end
