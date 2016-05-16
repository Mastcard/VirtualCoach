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

- (void)addMovieFileOutput
{
    [_captureSession.captureSession beginConfiguration];
    
    if ([_captureSession.captureSession canAddOutput:_captureSession.captureMovieFileOutput])
    {
        //NSLog(@"Output changed to AVCaptureMovieFileOutput");
        [_captureSession.captureSession addOutput:_captureSession.captureMovieFileOutput];
        
        AVCaptureConnection *videoConnection = nil;
        
        for ( AVCaptureConnection *connection in [_captureSession.captureMovieFileOutput connections] )
        {
            for ( AVCaptureInputPort *port in [connection inputPorts] )
            {
                if ( [[port mediaType] isEqual:AVMediaTypeVideo] )
                {
                    videoConnection = connection;
                }
            }
        }
        
        if([videoConnection isVideoOrientationSupported]) // **Here it is, its always false**
        {
            [videoConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
        }
    }
    
    [_captureSession.captureSession commitConfiguration];
}

- (void)addVideoDataOutput
{
    [_captureSession.captureSession beginConfiguration];
    
    if ([_captureSession.captureSession canAddOutput:_captureSession.captureVideoDataOutput])
    {
        //NSLog(@"Output changed to AVCaptureVideoDataOutput");
        [_captureSession.captureSession addOutput:_captureSession.captureVideoDataOutput];
    }
    
    [_captureSession.captureSession commitConfiguration];
}

- (void)removeOutput
{
    [_captureSession.captureSession beginConfiguration];
    
    if (_captureSession.captureSession.outputs.count > 0)
    {
        AVCaptureOutput *captureOutput = (AVCaptureOutput *)[_captureSession.captureSession.outputs objectAtIndex:0];
        
        if ([captureOutput isMemberOfClass:[AVCaptureMovieFileOutput class]])
        {
            [_captureSession.captureSession removeOutput:_captureSession.captureMovieFileOutput];
            //NSLog(@"Removed AVCaptureMovieFileOutput");
        }
        
        else if ([captureOutput isMemberOfClass:[AVCaptureVideoDataOutput class]])
        {
            [_captureSession.captureSession removeOutput:_captureSession.captureVideoDataOutput];
            //NSLog(@"Removed AVCaptureVideoDataOutput");
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
    
    //NSLog(@"Final video path : %@", _lastVideoUrl.path);
    
    [_captureSession.captureMovieFileOutput stopRecording];
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
