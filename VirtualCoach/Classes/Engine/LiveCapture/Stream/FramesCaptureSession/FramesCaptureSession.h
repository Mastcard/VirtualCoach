//
//  FramesCaptureSession.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSession.h"
#import <AVFoundation/AVFoundation.h>

@interface FramesCaptureSession : CaptureSession

@property (nonatomic, strong) AVCaptureVideoDataOutput *captureVideoDataOutput;
@property (nonatomic) dispatch_queue_t videoDataOutputQueue;

- (instancetype) __unavailable init;

@end
