//
//  FramesCaptureSessionController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSessionController.h"
#import "FramesCaptureSession.h"
#import "Process.h"
#import "Queue.h"

@interface FramesCaptureSessionController : CaptureSessionController// <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) FramesCaptureSession *captureSession;

@property (nonatomic, strong) id <AVCaptureVideoDataOutputSampleBufferDelegate, Process> sampleBufferDelegate;

- (instancetype) __unavailable init;
- (instancetype)initWithCaptureSession:(FramesCaptureSession *)captureSession;

- (void)startRetrievingFrames;
- (void)stopRetrievingFrames;

@end
