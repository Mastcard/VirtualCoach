//
//  VideoProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 10/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "VideoProcess.h"

@interface VideoProcess ()

@property (nonatomic, strong) NSDictionary *videoInfo;

@property (nonatomic) float globalProcessProgress;

@end

@implementation VideoProcess

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo
{
    self = [super init];
    
    if (self)
    {
        _videoInfo = videoInfo;
        
        _scale = 0.5;
        _skippedFrameCount = 200;
        _samplingCount = 10;
        _overlappingRate = 0.6;
        _shouldDeleteIrrelevantSequences = NO;
        _globalProcessProgress = 0.f;
    }
    
    return self;
}

- (void)setup
{
    NSString *videoPath = [_videoInfo objectForKey:@"videoPath"];
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    _trackingAnalysisProcess = [[TrackingAnalysisProcess alloc] initWithDictionary:_videoInfo];
    _trackingAnalysisProcess.scale = _scale;
    _trackingAnalysisProcess.skippedFrameCount = _skippedFrameCount;
    _trackingAnalysisProcess.motionImageFactor = _samplingCount;
    _trackingAnalysisProcess.overlappingRate = _overlappingRate;

    [_extractorProcess setDelegate:_trackingAnalysisProcess];
    [_trackingAnalysisProcess setDelegate:self];
    
    [_extractorProcess setup];
    [_trackingAnalysisProcess setup];
}

- (void)start
{
    // Starting tracking tracking analysis process
    
    [_delegate didUpdateStatusWithProgress:0.f message:@"Tracking player.."];
    [_extractorProcess start];
    
    NSDictionary *motionData = [_trackingAnalysisProcess motionData];
    
    NSArray *objectsMotion = (NSArray *)[motionData objectForKey:@"objectsMotion"];
    
    [_delegate didUpdateStatusWithProgress:0 message:@"Building relevant sequences.."];
    
    // build relevant sequences
    
    TrackingRelevantSequencesBuilder *relevantSequencesBuilder = [[TrackingRelevantSequencesBuilder alloc] initWithPartialMotionArray:objectsMotion motionImageFactor:_samplingCount];
    [relevantSequencesBuilder buildRelevantSequences];
    
    [_delegate didUpdateStatusWithProgress:0.25 message:@"Removing irrelevant sequences.."];
    
    NSMutableArray *finalObjectsMotion = [relevantSequencesBuilder retreiveRelevantSequences];
    
    NSArray *objectsPosition = (NSArray *)[motionData objectForKey:@"objectsPosition"];
    
    if (_shouldDeleteIrrelevantSequences)
    {
        TrackingIrrelevantSequencesRemover *irrelevantSequencesRemover = [[TrackingIrrelevantSequencesRemover alloc] initWithMotionArray:finalObjectsMotion objectsPosition:objectsPosition];
        [irrelevantSequencesRemover removeIrrelevantSequences];
    }
    
    //     choose relevant images (according to sequences) DEBUG : we take all but in the final process, we should only take the frames where the player doesn't move
    
    NSMutableArray *relevantSequencesInformations = [NSMutableArray array];
    
    for (NSUInteger i = 1; i < finalObjectsMotion.count; i++)
    {
        NSNumber *motionInfo = (NSNumber *)[finalObjectsMotion objectAtIndex:i];
        
        TrackingObjectPosition *objPos = (TrackingObjectPosition *)[objectsPosition objectAtIndex:i];
        
        pt2d_t start = objPos.bounds.start, end = objPos.bounds.end;
        uint32_t tmp = start.x + start.y + end.x + end.y;
        
        if (tmp != 0) // we only take the images when the object was tracked (where the bounds are real motherfucker)
        {
            NSArray *imageInformationKeys = [NSArray arrayWithObjects:@"imageId", @"start.x", @"start.y", @"end.x", @"end.y", @"moves", nil];
            
            NSArray *imageInformationObjects = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInt:(unsigned int)objPos.imageId], [NSNumber numberWithUnsignedInt:objPos.bounds.start.x], [NSNumber numberWithUnsignedInt:objPos.bounds.start.y], [NSNumber numberWithUnsignedInt:objPos.bounds.end.x], [NSNumber numberWithUnsignedInt:objPos.bounds.end.y], [NSNumber numberWithInt:motionInfo.intValue], nil];
            
            NSDictionary *imageInformation = [NSDictionary dictionaryWithObjects:imageInformationObjects forKeys:imageInformationKeys];
            
            [relevantSequencesInformations addObject:imageInformation];
        }
    }
    
    // initializing data analysis process where optical flow and analysis will be called
    
    _dataAnalysisProcess = [[DataAnalysisProcess alloc] initWithDictionary:_videoInfo relevantSequences:relevantSequencesInformations];
    _dataAnalysisProcess.scale = _scale;
    _dataAnalysisProcess.skippedFrameCount = _skippedFrameCount;
    
    NSString *videoPath = [_videoInfo objectForKey:@"videoPath"];
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    [_extractorProcess setDelegate:_dataAnalysisProcess];
    [_dataAnalysisProcess setDelegate:self];
    
    [_extractorProcess setup];
    [_dataAnalysisProcess setup];
    
    [_delegate didUpdateStatusWithProgress:0.25 message:@"Analyzing motions.."];
    
    [_extractorProcess start];
    
    [_delegate didUpdateStatusWithProgress:0 message:@"Done!"];
}

- (void)didUpdateStatusWithProgress:(float)progress message:(NSString *)message
{
    [_delegate didUpdateStatusWithProgress:progress message:message];
}

- (void)stop
{
    
}

@end
