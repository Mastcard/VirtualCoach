//
//  MovieCaptureSession.h
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSession.h"
#import <AVFoundation/AVFoundation.h>

@interface MovieCaptureSession : CaptureSession

@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;

- (instancetype) __unavailable init;

@end
