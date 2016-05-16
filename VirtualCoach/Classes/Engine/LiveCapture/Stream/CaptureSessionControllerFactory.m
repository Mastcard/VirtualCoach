//
//  CaptureSessionControllerFactory.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSessionControllerFactory.h"
#import "MovieCaptureSession.h"
#import "FramesCaptureSession.h"

@implementation CaptureSessionControllerFactory

+ (MovieCaptureSessionController *)createMovieCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset
{
    MovieCaptureSession *movieCaptureSession = [[MovieCaptureSession alloc] initWithDevice:device sessionPreset:preset framerate:25];
    
    [movieCaptureSession setup];
    
    return [[MovieCaptureSessionController alloc] initWithCaptureSession:movieCaptureSession];
}

+ (FramesCaptureSessionController *)createFramesCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset sampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate,Process>)sampleBufferDelegate
{
    FramesCaptureSession *framesCaptureSession = [[FramesCaptureSession alloc] initWithDevice:device sessionPreset:preset framerate:25];
    
    [framesCaptureSession setup];
    
    FramesCaptureSessionController *framesCaptureSessionController = [[FramesCaptureSessionController alloc] initWithCaptureSession:framesCaptureSession];
    
    [framesCaptureSessionController setSampleBufferDelegate:sampleBufferDelegate];
    
    return framesCaptureSessionController;
}

+ (HybridCaptureSessionController *)createHybridCaptureSessionControllerWithDevice:(AVCaptureDevice *)device preset:(NSString *)preset sampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate,Process>)sampleBufferDelegate recordingDelegate:(id<AVCaptureFileOutputRecordingDelegate, Process>)recordingDelegate
{
    HybridCaptureSession *hybridCaptureSession = [[HybridCaptureSession alloc] initWithDevice:device sessionPreset:preset framerate:25];
    
    [hybridCaptureSession setup];
    
    HybridCaptureSessionController *hybridCaptureSessionController = [[HybridCaptureSessionController alloc] initWithCaptureSession:hybridCaptureSession];
    
    [hybridCaptureSessionController setSampleBufferDelegate:sampleBufferDelegate];
    [hybridCaptureSessionController setRecordingDelegate:recordingDelegate];
    
    return hybridCaptureSessionController;
}

@end
