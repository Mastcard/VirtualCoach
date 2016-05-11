//
//  CaptureDevicePropertiesUtilities.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaptureDevicePropertiesUtilities : NSObject

+ (NSString *)sessionPresetForLocalizedPreset:(NSString *)localizedPreset;
+ (NSString *)sessionLocalizedPresetForPreset:(NSString *)preset;
+ (NSString *)sessionPresetForVideoDimensionsWithWidth:(int32_t)width height:(int32_t)height;
+ (NSString *)sessionPresetForLocalizedVideoDimensions:(NSString *)localizedVideoDimensions;
+ (int32_t)widthForSessionPreset:(NSString *)preset;
+ (int32_t)heightForSessionPreset:(NSString *)preset;
+ (NSString *)localizedFramerateForFramerate:(int32_t)framerate;
+ (int32_t)framerateForLocalizedFramerate:(NSString *)localizedFramerate;

@end
