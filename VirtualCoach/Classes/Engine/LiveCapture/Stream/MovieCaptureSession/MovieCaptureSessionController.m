//
//  MovieCaptureSessionController.m
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "MovieCaptureSessionController.h"

@interface MovieCaptureSessionController ()

@property (nonatomic, strong) NSString *defaultDirectory;

@property (nonatomic, strong) NSURL *lastVideoUrl;

@end

@implementation MovieCaptureSessionController

@synthesize captureSession = _captureSession;

- (instancetype)initWithCaptureSession:(MovieCaptureSession *)captureSession
{
    self = [super initWithCaptureSession:captureSession];
    
    if (self)
    {
        _captureSession = captureSession;
    }
    
    return self;
}

- (void)startRecordingMovieAtURL:(NSURL *)url
{
    NSNumber *isDirectory;
    
    BOOL success = [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
    if (success && [isDirectory boolValue])
    {
        NSDateFormatter *formatter;
        NSString *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd_HH.mm.ss"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [dateString stringByAppendingPathExtension:@"mov"];
        
        _lastVideoUrl = [NSURL fileURLWithPath:[url.path stringByAppendingPathComponent:fileName]];
    }
    
    else
    {
        _lastVideoUrl = url;
    }
    
    [_captureSession.captureMovieFileOutput startRecordingToOutputFileURL:_lastVideoUrl recordingDelegate:_recordingDelegate];
}

- (void)stopRecordingMovie
{
    [_captureSession.captureMovieFileOutput stopRecording];
}

- (NSURL *)lastVideoUrl
{
    return _lastVideoUrl;
}

@end
