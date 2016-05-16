//
//  CaptureDevicePropertiesRetriever.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "NSOrderedDictionary.h"

@interface CaptureDevicePropertiesRetriever : NSObject

+ (NSOrderedDictionary *)supportedPresetsForDevice:(AVCaptureDevice *)device;
+ (NSOrderedDictionary *)supportedFrameratesForDevice:(AVCaptureDevice *)device preset:(NSString *)preset;

@end
