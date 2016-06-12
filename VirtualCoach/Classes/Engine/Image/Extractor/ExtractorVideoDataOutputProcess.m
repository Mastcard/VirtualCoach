//
//  ExtractorVideoDataOutputProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "ExtractorVideoDataOutputProcess.h"

@interface ExtractorVideoDataOutputProcess ()

@property (nonatomic, strong) NSString *filePath;
@property (assign) BOOL canExtract;
@property (nonatomic, strong) AVURLAsset *url;
@property (nonatomic, strong) AVAssetReader *reader;
@property (nonatomic, strong) AVAssetReaderTrackOutput *readerTrackOutput;

@end

@implementation ExtractorVideoDataOutputProcess

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class ExtractorProcess (use -initWithFile:filePath)"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithFile:(NSString *)filePath
{
    self = [super init];
    
    if (self)
    {
        _filePath = filePath;
        _canExtract = NO;
        
        NSURL *movieURL = [[NSURL alloc] initFileURLWithPath:filePath];
        
        if ([movieURL isFileURL]) _url = [[AVURLAsset alloc] initWithURL:movieURL options:nil];
        else NSLog(@"The specified path does not provide a file");
    }
    
    return self;
}

- (void)setup
{
    NSArray *videoTracks = [_url tracksWithMediaType:AVMediaTypeVideo];
    
    if ([videoTracks count] > 0)
    {
        AVAssetTrack *videoTrack = [videoTracks objectAtIndex:0];
        
        Float64 frameCount = CMTimeGetSeconds(_url.duration) * videoTrack.nominalFrameRate;
        [_delegate didEstimateFrameCount:frameCount];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
        
        _readerTrackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:dict];
        
        NSError *error = nil;
        _reader = [[AVAssetReader alloc] initWithAsset:_url error:&error];
        
        if([_reader canAddOutput:_readerTrackOutput])
        {
            [_reader addOutput:_readerTrackOutput];
            
            if ([_reader startReading] == YES)
            {
                _canExtract = YES;
                
                NSLog(@"ExtractorVideoDataOutputProcess : file path : %@", self.filePath);
            }
            
            else
            {
                NSLog(@"ExtractorVideoDataOutputProcess : reader is not starting the reading");
            }
        }
        
        else
        {
            NSLog(@"ExtractorVideoDataOutputProcess : reader can't add output.");
        }
    }
    
    else
    {
        NSLog(@"ExtractorVideoDataOutputProcess : video media type not found in the specified file");
    }
}

- (void)start
{
    if (_canExtract)
    {
        BOOL done = NO;
        
        while (!done)
        {
            CMSampleBufferRef sampleBuffer = [_readerTrackOutput copyNextSampleBuffer];
            
            if (sampleBuffer)
            {
                [_delegate didOutputSampleBuffer:sampleBuffer];
                
                CFRelease(sampleBuffer);
                sampleBuffer = NULL;
            }
            
            else
            {
                if (_reader.status == AVAssetReaderStatusFailed)
                {
                    NSError *failureError = _reader.error;
                    
                    NSLog(@"%@", failureError.description);
                }
                else
                {
                    done = YES;
                }
            }
        }
        
        NSLog(@"Extractor : all frames have been decoded.");
    }
    
    else
    {
        NSLog(@"Extractor can not extract.");
    }
}

- (void)stop
{
    _canExtract = NO;
}

- (void)pause
{
    
}

- (void)resume
{
    
}

- (void)reset
{
    [self setup];
}

- (BOOL)running
{
    return YES;
}

@end
