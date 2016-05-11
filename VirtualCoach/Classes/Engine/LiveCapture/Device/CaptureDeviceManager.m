//
//  CaptureDeviceManager.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureDeviceManager.h"

@implementation CaptureDeviceManager

+ (NSArray *)devices
{
    NSArray *devices = [AVCaptureDevice devices];
    NSMutableArray *videoDevices = [[NSMutableArray alloc] init];
    
    for (AVCaptureDevice *device in devices)
        if ([device hasMediaType:AVMediaTypeVideo])
            [videoDevices addObject:device];
    
    return videoDevices;
}

+ (AVCaptureDevice *)uniqueDeviceWithPosition:(AVCaptureDevicePosition)devicePosition
{
    NSArray *devices = [CaptureDeviceManager devices];
    
    for (AVCaptureDevice *device in devices)
        if ([device position] == devicePosition)
            return device;
        
    return nil;
}

@end
