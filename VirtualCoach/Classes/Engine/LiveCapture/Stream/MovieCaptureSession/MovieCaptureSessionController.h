//
//  MovieCaptureSessionController.h
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSessionController.h"
#import <AVFoundation/AVFoundation.h>
#import "MovieCaptureSession.h"
#import "Process.h"

@interface MovieCaptureSessionController : CaptureSessionController

@property (nonatomic, strong) MovieCaptureSession *captureSession;
@property (nonatomic, strong) id <AVCaptureFileOutputRecordingDelegate, Process> recordingDelegate;

- (instancetype) __unavailable init;

- (instancetype)initWithCaptureSession:(MovieCaptureSession *)captureSession;

- (void)startRecordingMovieAtURL:(NSURL *)url;
- (void)stopRecordingMovie;

- (NSURL *)lastVideoUrl;

@end
