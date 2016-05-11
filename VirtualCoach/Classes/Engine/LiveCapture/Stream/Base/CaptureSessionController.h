//
//  CaptureSessionController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CaptureSession.h"

@interface CaptureSessionController : NSObject

@property (nonatomic, strong) CaptureSession *captureSession;

- (instancetype) __unavailable init;

- (instancetype)initWithCaptureSession:(CaptureSession *)captureSession;
- (void)startSession;
- (void)stopSession;
- (void)switchToCaptureDevice:(AVCaptureDevice *)captureDevice;
- (void)changeSessionPreset:(NSString *)sessionPreset;
- (void)changeSessionFramerate:(int32_t)framerate;

@end
