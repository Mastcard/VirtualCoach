//
//  CaptureDevicePropertiesUtilities.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureDevicePropertiesUtilities.h"
#import <AVFoundation/AVFoundation.h>

@implementation CaptureDevicePropertiesUtilities

+ (NSString *)sessionPresetForLocalizedPreset:(NSString *)localizedPreset
{
    if ([localizedPreset isEqualToString:@"480p"])
        return AVCaptureSessionPreset640x480;
    
    if ([localizedPreset isEqualToString:@"720p"])
        return AVCaptureSessionPreset1280x720;
    
    if ([localizedPreset isEqualToString:@"1080p"])
        return AVCaptureSessionPreset1920x1080;
    
    return nil;
}

+ (NSString *)sessionLocalizedPresetForPreset:(NSString *)preset
{
    if ([preset isEqualToString:AVCaptureSessionPreset352x288])
        return @"288p";
    
    if ([preset isEqualToString:AVCaptureSessionPreset640x480])
        return @"480p";
    
    if ([preset isEqualToString:AVCaptureSessionPreset1280x720])
        return @"720p";
    
    if ([preset isEqualToString:AVCaptureSessionPreset1920x1080])
        return @"1080p";
    
    return nil;
}

+ (NSString *)sessionPresetForVideoDimensionsWithWidth:(int32_t)width height:(int32_t)height
{
    return [self sessionPresetForLocalizedVideoDimensions:[NSString stringWithFormat:@"%dx%d", width, height]];
}

+ (NSString *)sessionPresetForLocalizedVideoDimensions:(NSString *)localizedVideoDimensions
{
    if ([localizedVideoDimensions isEqualToString:@"192x144"])
        return nil;
    
    if ([localizedVideoDimensions isEqualToString:@"352x288"])
        return nil;//AVCaptureSessionPreset352x288 seems not supported on iPad;
    
    if ([localizedVideoDimensions isEqualToString:@"480x360"])
        return nil;
    
    if ([localizedVideoDimensions isEqualToString:@"640x480"])
        return AVCaptureSessionPreset640x480;
    
    if ([localizedVideoDimensions isEqualToString:@"960x540"])
        return nil;
    
    if ([localizedVideoDimensions isEqualToString:@"1280x720"])
        return AVCaptureSessionPreset1280x720;
    
    if ([localizedVideoDimensions isEqualToString:@"1920x1080"])
        return AVCaptureSessionPreset1920x1080;
    
    if ([localizedVideoDimensions isEqualToString:@"2592x1936"])
        return nil;
    
    if ([localizedVideoDimensions isEqualToString:@"3840x2160"])
        return AVCaptureSessionPreset3840x2160;
    
    return nil;
}

+ (int32_t)widthForSessionPreset:(NSString *)preset
{
    if ([preset isEqualToString:AVCaptureSessionPreset640x480])
        return 640;
    
    if ([preset isEqualToString:AVCaptureSessionPreset1280x720])
        return 1280;
    
    if ([preset isEqualToString:AVCaptureSessionPreset1920x1080])
        return 1920;
    
    return -1;
}

+ (int32_t)heightForSessionPreset:(NSString *)preset
{
    if ([preset isEqualToString:AVCaptureSessionPreset640x480])
        return 480;
    
    if ([preset isEqualToString:AVCaptureSessionPreset1280x720])
        return 720;
    
    if ([preset isEqualToString:AVCaptureSessionPreset1920x1080])
        return 1080;
    
    return -1;
}

+ (NSString *)localizedFramerateForFramerate:(int32_t)framerate
{
    return [NSString stringWithFormat:@"%dfps", framerate];
}

+ (int32_t)framerateForLocalizedFramerate:(NSString *)localizedFramerate
{
    return [[localizedFramerate stringByReplacingOccurrencesOfString:@"fps" withString:@""] intValue];
}

@end
