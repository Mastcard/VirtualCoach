//
//  HybridCaptureSession.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "HybridCaptureSession.h"

@implementation HybridCaptureSession

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate
{
    self = [super initWithDevice:captureDevice sessionPreset:sessionPreset framerate:framerate];
    
    if (self)
    {
        _captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    }
    
    return self;
}

- (void)setup
{
    [super setup];
    
    NSDictionary *newSettings = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    _captureVideoDataOutput.videoSettings = newSettings;
    _captureVideoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    
    _videoDataOutputQueue = dispatch_queue_create("HCS_VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    
    _captureMovieFileOutput.maxRecordedDuration = kCMTimeInvalid;
    
    // by default, AVCaptureVideoDataOutput is added to the session
    
    if (![self.captureSession canAddOutput:_captureVideoDataOutput])
    {
        NSLog(@"FramesCaptureSession : session can't add the video data output.");
        return;
    }
    
    [self.captureSession addOutput:_captureVideoDataOutput];
}

@end
