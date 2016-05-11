//
//  FramesCaptureSession.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "FramesCaptureSession.h"

@implementation FramesCaptureSession

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate
{
    self = [super initWithDevice:captureDevice sessionPreset:sessionPreset framerate:framerate];
    
    if (self)
    {
        _captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    }
    
    return self;
}

- (void)setup
{
    [super setup];
    
    NSDictionary *newSettings =
    @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    _captureVideoDataOutput.videoSettings = newSettings;
    
    [_captureVideoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    
    
    
    _videoDataOutputQueue = dispatch_queue_create("FCS_VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    
    if (![self.captureSession canAddOutput:_captureVideoDataOutput])
    {
        NSLog(@"FramesCaptureSession : session can't add the video data output.");
        return;
    }
    
    [self.captureSession addOutput:_captureVideoDataOutput];
}

@end
