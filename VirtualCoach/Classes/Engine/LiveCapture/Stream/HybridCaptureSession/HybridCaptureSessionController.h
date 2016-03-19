//
//  HybridCaptureSessionController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CaptureSessionController.h"
#import "HybridCaptureSession.h"

@interface HybridCaptureSessionController : CaptureSessionController

@property (nonatomic, strong) HybridCaptureSession *captureSession;

@property (nonatomic, strong) id <AVCaptureVideoDataOutputSampleBufferDelegate, Process> sampleBufferDelegate;

@property (nonatomic, strong) id <AVCaptureFileOutputRecordingDelegate, Process> recordingDelegate;

- (instancetype) __unavailable init;

- (instancetype)initWithCaptureSession:(HybridCaptureSession *)captureSession;

- (void)addMovieFileOutput;
- (void)addVideoDataOutput;
- (void)removeOutput;

- (void)startRetrievingFrames;
- (void)stopRetrievingFrames;

- (void)startRecordingMovieAtURL:(NSURL *)url;
- (void)stopRecordingMovie;

- (NSURL *)lastVideoUrl;

@end
