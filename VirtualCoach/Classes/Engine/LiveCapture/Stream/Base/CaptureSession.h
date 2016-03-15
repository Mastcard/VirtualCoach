//
//  CaptureSession.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CaptureSession : NSObject

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;

@property (nonatomic, strong) NSString *sessionPreset;
@property (nonatomic) int32_t framerate;

- (instancetype) __unavailable init;
- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate;
- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset;
- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice;

- (void)setFramerate:(int32_t)framerate format:(AVCaptureDeviceFormat *)format;

- (void)setup;

@end
