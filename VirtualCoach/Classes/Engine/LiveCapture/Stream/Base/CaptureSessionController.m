//
//  CaptureSessionController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSessionController.h"
#import "CaptureDevicePropertiesUtilities.h"
#import "CaptureSession.h"

@implementation CaptureSessionController

- (instancetype)initWithCaptureSession:(CaptureSession *)captureSession
{
    self = [super init];
    
    if (self)
    {
        _captureSession = captureSession;
    }
    
    return self;
}

- (void)startSession
{
    [_captureSession.captureSession startRunning];
}

- (void)stopSession
{
    [_captureSession.captureSession stopRunning];
}

- (void)switchToCaptureDevice:(AVCaptureDevice *)captureDevice
{
    NSError *captureDeviceInputError;
    
    AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&captureDeviceInputError];
    
    if (!captureDeviceInput)
    {
        NSLog(@"CaptureSessionController : error during device switching (domain = %@, code = %ld)", captureDeviceInputError.domain, (long)captureDeviceInputError.code);
        return;
    }
    
    NSString *oldSessionPreset = _captureSession.captureSession.sessionPreset;
    
    int32_t oldFramerate = _captureSession.framerate;
    
    [_captureSession.captureSession beginConfiguration];
    
    [_captureSession.captureSession removeInput:_captureSession.captureDeviceInput];
    
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh]; // just in case the new device does not support old session, we assign its high supported preset
    [_captureSession.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_captureSession setCaptureDevice:captureDevice];
    [_captureSession setCaptureDeviceInput:captureDeviceInput];
    
    [_captureSession.captureSession addInput:captureDeviceInput];
    
    [_captureSession.captureSession commitConfiguration];
    
    [self changeSessionPreset:oldSessionPreset];
    [self changeSessionFramerate:oldFramerate];
}

- (void)changeSessionPreset:(NSString *)sessionPreset
{
    if ([_captureSession.captureSession canSetSessionPreset:sessionPreset])
    {
        [_captureSession.captureSession beginConfiguration];
        
        [_captureSession setSessionPreset:sessionPreset];
        [_captureSession.captureSession setSessionPreset:sessionPreset];
        
        [_captureSession.captureSession commitConfiguration];
    }
}

- (void)changeSessionFramerate:(int32_t)framerate
{
    BOOL validPreset = NO;
    AVCaptureDevice *currentDevice = _captureSession.captureDevice;
    
    int32_t currentSessionPresetWidth = [CaptureDevicePropertiesUtilities widthForSessionPreset:_captureSession.sessionPreset];
    int32_t currentSessionPresetHeight = [CaptureDevicePropertiesUtilities heightForSessionPreset:_captureSession.sessionPreset];
    
    AVCaptureDeviceFormat *bestFormat = nil;
    
    for (AVCaptureDeviceFormat *format in [currentDevice formats])
    {
        CMFormatDescriptionRef formatDescription = format.formatDescription;
        CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription);
        
        if ((dimensions.width == currentSessionPresetWidth) && (dimensions.height == currentSessionPresetHeight))
        {
            for (AVFrameRateRange *range in format.videoSupportedFrameRateRanges)
            {
                if ((framerate >= range.minFrameRate) && (framerate <= range.maxFrameRate))
                {
                    bestFormat = format;
                    validPreset = YES;
                    break;
                }
            }
        }
        
        if (validPreset)
            break;
    }
    
    if (validPreset)
        [_captureSession setFramerate:framerate format:bestFormat];
    else
    {
        NSArray *deviceSupportedFrameRateRanges = _captureSession.captureDevice.activeFormat.videoSupportedFrameRateRanges;
        
        AVFrameRateRange *bestRange = nil;
        
        for (AVFrameRateRange *range in deviceSupportedFrameRateRanges)
        {
            if ((framerate >= range.minFrameRate) && (framerate <= range.maxFrameRate))
            {
                bestRange = range;
                break;
            }
        }
        
        [_captureSession setFramerate:(int32_t)bestRange.maxFrameRate];
    }
    
}

@end
