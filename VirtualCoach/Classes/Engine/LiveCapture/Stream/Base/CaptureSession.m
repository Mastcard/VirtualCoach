//
//  CaptureSession.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSession.h"
#import "CaptureDevicePropertiesUtilities.h"

@implementation CaptureSession

- (instancetype)init
{
    return [self initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]];
}

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate
{
    self = [super init];
    
    if (self)
    {
        _captureSession = [[AVCaptureSession alloc] init];
        _captureDevice = captureDevice;
        _sessionPreset = sessionPreset;
        _framerate = framerate;
    }
    
    return self;
}

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice
{
    return [self initWithDevice:captureDevice sessionPreset:AVCaptureSessionPresetMedium framerate:25];
}

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset
{
    return [self initWithDevice:captureDevice sessionPreset:sessionPreset framerate:25];
}

- (void)setFramerate:(int32_t)framerate format:(AVCaptureDeviceFormat *)format
{
    _framerate = framerate;
    
    if ([_captureDevice lockForConfiguration:NULL] == YES)
    {
        CMTime videoFrameDuration = CMTimeMake(1, _framerate);
        
        [_captureDevice setActiveFormat:format];
        [_captureDevice setActiveVideoMinFrameDuration:videoFrameDuration];
        [_captureDevice setActiveVideoMaxFrameDuration:videoFrameDuration];
        [_captureDevice unlockForConfiguration];
    }
}

- (void)setup
{
    NSError *captureDeviceInputError;
    
    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&captureDeviceInputError];
    
    if (!_captureDeviceInput)
    {
        NSLog(@"CaptureSession : error during setup (domain = %@, code = %ld)", captureDeviceInputError.domain, (long)captureDeviceInputError.code);
        return;
    }
    
    [_captureSession beginConfiguration];
    
    if (![_captureSession canAddInput:_captureDeviceInput])
    {
        NSLog(@"CaptureSession : session can't add the capture device input.");
        return;
    }
    
    [_captureSession addInput:_captureDeviceInput];
    
    if (![_captureSession canSetSessionPreset:_sessionPreset])
    {
        NSLog(@"CaptureSession : session can't set the session preset %@.", _sessionPreset);
        return;
    }
    
    [_captureSession setSessionPreset:_sessionPreset];
    
    [_captureSession commitConfiguration];
}

@end
