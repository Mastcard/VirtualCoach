//
//  CaptureDevicePropertiesRetriever.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureDevicePropertiesRetriever.h"
#import "CaptureDevicePropertiesUtilities.h"
#import <AVFoundation/AVFoundation.h>

@implementation CaptureDevicePropertiesRetriever

+ (NSOrderedDictionary *)supportedPresetsForDevice:(AVCaptureDevice *)device
{
    NSMutableArray *presets = [[NSMutableArray alloc] init];
    NSMutableArray *localizedPresets = [[NSMutableArray alloc] init];
    
    for (AVCaptureDeviceFormat *format in [device formats])
    {
        CMVideoDimensions videoDimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription);
        
        NSString *sessionPreset = [CaptureDevicePropertiesUtilities sessionPresetForVideoDimensionsWithWidth:videoDimensions.width height:videoDimensions.height];
        
        NSString *localizedSessionPreset = [CaptureDevicePropertiesUtilities sessionLocalizedPresetForPreset:sessionPreset];
        
        if (![presets containsObject:sessionPreset] && sessionPreset)
        {
            [presets addObject:sessionPreset];
            [localizedPresets addObject:localizedSessionPreset];
        }
    }
    
    NSOrderedDictionary *supportedPresets = [[NSOrderedDictionary alloc] initWithObjects:presets forKeys:localizedPresets];
    
    return supportedPresets;
}

+ (NSOrderedDictionary *)supportedFrameratesForDevice:(AVCaptureDevice *)device preset:(NSString *)preset
{
    CMVideoDimensions presetVideoDimensions;
    presetVideoDimensions.width = [CaptureDevicePropertiesUtilities widthForSessionPreset:preset];
    presetVideoDimensions.height = [CaptureDevicePropertiesUtilities heightForSessionPreset:preset];
    
    NSMutableArray *framerates = [[NSMutableArray alloc] init];
    NSMutableArray *localizedFramerates = [[NSMutableArray alloc] init];
    
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    
    for (AVCaptureDeviceFormat *format in [device formats])
    {
        CMVideoDimensions formatVideoDimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription);
        
        if ((formatVideoDimensions.width == presetVideoDimensions.width) && (formatVideoDimensions.height == presetVideoDimensions.height))
        {
            for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges )
            {
                if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate )
                {
                    bestFormat = format;
                    bestFrameRateRange = range;
                }
            }
        }
    }
    
    if (bestFormat)
    {
        int currentFramerate = 20;
        
        [framerates addObject:[NSNumber numberWithInt:currentFramerate]];
        [localizedFramerates addObject:[CaptureDevicePropertiesUtilities localizedFramerateForFramerate:currentFramerate]];
        
        BOOL finish = NO;
        
        while (!finish)
        {
            if ((currentFramerate + 5) < bestFrameRateRange.maxFrameRate)
            {
                currentFramerate += 5;
                [framerates addObject:[NSNumber numberWithInt:currentFramerate]];
                [localizedFramerates addObject:[CaptureDevicePropertiesUtilities localizedFramerateForFramerate:currentFramerate]];
            }
            
            else
            {
                finish = YES;
            }
        }
        
        [framerates addObject:[NSNumber numberWithInt:bestFrameRateRange.maxFrameRate]];
        [localizedFramerates addObject:[CaptureDevicePropertiesUtilities localizedFramerateForFramerate:bestFrameRateRange.maxFrameRate]];
    }
    
    NSOrderedDictionary *supportedFramerates = [[NSOrderedDictionary alloc] initWithObjects:framerates forKeys:localizedFramerates];
    
    return supportedFramerates;
}

@end
