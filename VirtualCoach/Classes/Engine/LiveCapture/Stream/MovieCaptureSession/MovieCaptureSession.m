//
//  MovieCaptureSession.m
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "MovieCaptureSession.h"

@implementation MovieCaptureSession

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate
{
    self = [super initWithDevice:captureDevice sessionPreset:sessionPreset framerate:framerate];
    
    if (self)
    {
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    }
    
    return self;
}

- (void)setup
{
    [super setup];
    
    _captureMovieFileOutput.maxRecordedDuration = kCMTimeInvalid;
    
    if (![self.captureSession canAddOutput:_captureMovieFileOutput])
    {
        NSLog(@"MovieCaptureSession : session can't add the capture movie file output.");
        return;
    }
    
    [self.captureSession addOutput:_captureMovieFileOutput];
}

@end
