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
    
    AVCaptureDeviceFormat *bestFormat = nil;
    
    // setting to 60 fps by choosing highest rate range..
    
    AVCaptureDevice *currentDevice = self.captureDevice;
    
    int32_t currentSessionPresetWidth = [CaptureDevicePropertiesUtilities widthForSessionPreset:self.captureSession.sessionPreset];
    int32_t currentSessionPresetHeight = [CaptureDevicePropertiesUtilities heightForSessionPreset:self.captureSession.sessionPreset];
    
    BOOL validPreset = NO;
    
    for (AVCaptureDeviceFormat *format in [currentDevice formats])
    {
        CMFormatDescriptionRef formatDescription = format.formatDescription;
        CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription);
        
        if ((dimensions.width == currentSessionPresetWidth) && (dimensions.height == currentSessionPresetHeight))
        {
            for (AVFrameRateRange *range in format.videoSupportedFrameRateRanges)
            {
                if ((self.framerate >= range.minFrameRate) && (self.framerate <= range.maxFrameRate))
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
    
    if (bestFormat)
    {
        if ([self.captureDevice lockForConfiguration:NULL] == YES)
        {
            self.captureDevice.activeFormat = bestFormat;
            self.captureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 60);
            self.captureDevice.activeVideoMaxFrameDuration = CMTimeMake(1, 60);
            [self.captureDevice unlockForConfiguration];
        }
    }
}

@end
