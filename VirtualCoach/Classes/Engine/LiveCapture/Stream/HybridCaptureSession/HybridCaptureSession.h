//
//  HybridCaptureSession.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CaptureSession.h"
#import "Process.h"
#import "CaptureDevicePropertiesUtilities.h"

@interface HybridCaptureSession : CaptureSession

@property (nonatomic, strong) AVCaptureVideoDataOutput *captureVideoDataOutput;

@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;

@property (nonatomic) dispatch_queue_t videoDataOutputQueue;

- (instancetype) __unavailable init;

@end
