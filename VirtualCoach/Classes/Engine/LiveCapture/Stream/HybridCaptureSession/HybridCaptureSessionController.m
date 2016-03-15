//
//  HybridCaptureSessionController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "HybridCaptureSessionController.h"

@interface HybridCaptureSessionController ()

@property (nonatomic, strong) NSURL *lastVideoUrl;

@end

@implementation HybridCaptureSessionController

@synthesize captureSession = _captureSession;

- (instancetype)initWithCaptureSession:(HybridCaptureSession *)captureSession
{
    self = [super initWithCaptureSession:captureSession];
    
    if (self)
    {
        _captureSession = captureSession;
    }
    
    return self;
}

- (void)switchCaptureOutput
{
    AVCaptureOutput *captureOutput = (AVCaptureOutput *)[_captureSession.captureSession.outputs objectAtIndex:0];
    
    [_captureSession.captureSession beginConfiguration];
    
    if ([captureOutput isMemberOfClass:[AVCaptureMovieFileOutput class]])
    {
        if ([_captureSession.captureSession canAddOutput:_captureSession.captureVideoDataOutput])
        {
            NSLog(@"Output changed to AVCaptureVideoDataOutput");
            [_captureSession.captureSession removeOutput:_captureSession.captureMovieFileOutput];
            [_captureSession.captureSession addOutput:_captureSession.captureVideoDataOutput];
        }
        
        else
        {
            NSLog(@"Can't change output to AVCaptureVideoDataOutput");
        }
    }
    
    else if ([captureOutput isMemberOfClass:[AVCaptureVideoDataOutput class]])
    {
        if ([_captureSession.captureSession canAddOutput:_captureSession.captureMovieFileOutput])
        {
            NSLog(@"Output changed to AVCaptureMovieFileOutput");
            [_captureSession.captureSession removeOutput:_captureSession.captureVideoDataOutput];
            [_captureSession.captureSession addOutput:_captureSession.captureMovieFileOutput];
        }
        
        else
        {
            NSLog(@"Can't change output to AVCaptureMovieFileOutput");
        }
    }
    
    [_captureSession.captureSession commitConfiguration];
}

- (void)startRetrievingFrames
{
    [_sampleBufferDelegate start];
}

- (void)stopRetrievingFrames
{
    [_sampleBufferDelegate stop];
}

- (void)startRecordingMovieAtURL:(NSURL *)url
{
    NSDateFormatter *formatter;
    NSString *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH.mm.ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    NSString *fileName = [dateString stringByAppendingPathExtension:@"mov"];
    
    _lastVideoUrl = [NSURL fileURLWithPath:[url.path stringByAppendingPathComponent:fileName]];
    
    NSLog(@"Final vidoe path : %@", _lastVideoUrl.absoluteString);
    
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
