//
//  CaptureSessionControllerFactory.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FramesCaptureSessionController.h"
#import "MovieCaptureSessionController.h"
#import "HybridCaptureSessionController.h"

@interface CaptureSessionControllerFactory : NSObject

+ (MovieCaptureSessionController *)createMovieCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset;

+ (FramesCaptureSessionController *)createFramesCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset sampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate,Process>)sampleBufferDelegate;

+ (HybridCaptureSessionController *)createHybridCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset sampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate,Process>)sampleBufferDelegate recordingDelegate:(id<AVCaptureFileOutputRecordingDelegate, Process>)recordingDelegate;

@end
