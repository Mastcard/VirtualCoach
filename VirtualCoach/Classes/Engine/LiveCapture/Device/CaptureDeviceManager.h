//
//  CaptureDeviceManager.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CaptureSession.h"

@interface CaptureDeviceManager : NSObject

+ (NSArray *)devices;
+ (AVCaptureDevice *)uniqueDeviceWithPosition:(AVCaptureDevicePosition)devicePosition;

@end
