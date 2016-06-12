//
//  TrackingAnalysisProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrackingAnalysisProcess.h"

@interface TrackingAnalysisProcess ()

@property (nonatomic, strong) NSDictionary *videoInfo;
@property (nonatomic, assign) NSUInteger frameCount;
@property (nonatomic, assign) uint8_t binaryThreshold;
@property (nonatomic, assign) rect_t playerBounds;
@property (nonatomic, assign) gray8i_t *referenceFrame;
@property (nonatomic, strong) NSString *framesDirectoryPath;
@property (nonatomic, assign) BOOL canTrack;

- (void)loadReferenceFrame;
- (void)loadTrackingInformations;

@property (nonatomic, assign) regchar_t *previousReg;
@property (nonatomic, assign) labels_t *previousLabels;

@property (nonatomic, strong) NSMutableArray *objectsMotionArray;
@property (nonatomic, strong) NSMutableArray *objectsPositionArray;

//temp
@property (nonatomic, assign) regchar_t *previousMotionReg;
@property (nonatomic, assign) labels_t *previousMotionLabels;

@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger exportCount;

@end

@implementation TrackingAnalysisProcess

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo
{
    self = [super init];
    
    if (self)
    {
        _videoInfo = videoInfo;
        _canTrack = NO;
        _scale = 1.f;
        
        //temp
        _count = 0;
        _exportCount = 1;
        
        _frameCount = 0;
        
        _motionImageFactor = 10;
        _overlappingRate = 0.6;
    }
    
    return self;
}

- (void)loadReferenceFrame
{
    NSString *referenceFramePath = [_videoInfo objectForKey:@"referenceFramePath"];
    
    NSLog(@"referenceFramePath : %@", referenceFramePath);
    
    gray8i_t *originalReferenceFrame = pgmopen([referenceFramePath cStringUsingEncoding:NSASCIIStringEncoding]);
    
    CGImageRef originalReferenceFrameCg = [ImageTools gray8iToCgImage:originalReferenceFrame];
    CGImageRef scaledReferenceFrame = [ImageTools scaleCgimage:originalReferenceFrameCg scale:_scale];
    
    _referenceFrame = [ImageTools cgImageToGrayImage:scaledReferenceFrame];
    
    CGImageRelease(originalReferenceFrameCg);
    CGImageRelease(scaledReferenceFrame);
    gray8ifree(originalReferenceFrame);
}

- (void)loadTrackingInformations
{
    _binaryThreshold = (uint8_t)((NSNumber *)[_videoInfo objectForKey:@"binaryThreshold"]).unsignedIntValue;
    
    NSDictionary *playerBoundsDict = [_videoInfo objectForKey:@"lastPlayerBounds"];
    
    _playerBounds.start.x = ((NSNumber *)[playerBoundsDict objectForKey:@"start.x"]).unsignedIntValue;
    _playerBounds.start.y = ((NSNumber *)[playerBoundsDict objectForKey:@"start.y"]).unsignedIntValue;
    _playerBounds.end.x = ((NSNumber *)[playerBoundsDict objectForKey:@"end.x"]).unsignedIntValue;
    _playerBounds.end.y = ((NSNumber *)[playerBoundsDict objectForKey:@"end.y"]).unsignedIntValue;
}

- (void)setup
{
    [self loadReferenceFrame];
    [self loadTrackingInformations];
    
    _objectsMotionArray = [[NSMutableArray alloc] initWithCapacity:_frameCount];
    _objectsPositionArray = [[NSMutableArray alloc] initWithCapacity:_frameCount];
    
    _canTrack = YES;
}

- (void)didEstimateFrameCount:(Float64)frameCount
{
    _frameCount = (NSUInteger)frameCount;
    //NSLog(@"TrackingAnalysisProcess frame count received : %lu", (unsigned long)_frameCount);
}

- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (_canTrack)
    {
        //temp
        _count++;
        
        CGImageRef rgbImage = [ImageTools cgImageFromSampleBuffer:sampleBuffer];
        CGImageRef rgbImageScaled = [ImageTools scaleCgimage:rgbImage scale:_scale];
        
        gray8i_t *src = [ImageTools cgImageToGrayImage:rgbImageScaled];
        
        CGImageRelease(rgbImage);
        CGImageRelease(rgbImageScaled);
        
        if (_count == _skippedFrameCount)
        {
            gray8i_t *pre_isubstract = subgray8i(src, _referenceFrame);
            bini_t *pre_binary = binarise(pre_isubstract, _binaryThreshold);
            labels_t *pre_labels = label(pre_binary);
            charact_t *pre_characterization = characterize(NULL, src, pre_labels);
            
            rect_t newPLayerBounds;
            newPLayerBounds.start.x = _playerBounds.start.x * _scale;
            newPLayerBounds.start.y = _playerBounds.start.y * _scale;
            newPLayerBounds.end.x = _playerBounds.end.x * _scale;
            newPLayerBounds.end.y = _playerBounds.end.y * _scale;
            
            int32_t playerRegionId = regionAtZone(newPLayerBounds, pre_labels);
            
            gray8ifree(pre_isubstract);
            binifree(pre_binary);
            
            _previousReg = regcharcpy(pre_characterization->data[playerRegionId-1]);
            
            charactfree(pre_characterization);
            
            _previousLabels = pre_labels;
            _previousMotionLabels = labcpy(pre_labels);
            _previousMotionReg = regcharcpy(_previousReg);
            
            // lazy way to add the first image
            [_objectsPositionArray addObject:[NSNull null]];
            [_objectsMotionArray addObject:[NSNumber numberWithInt:1]];
        }
        
        else if (_count > _skippedFrameCount)
        {
            _exportCount++;
            
            gray8i_t *isubstract = subgray8i(src, _referenceFrame);
            
            bini_t *binary = binarise(isubstract, _binaryThreshold);
            
            labels_t *nextLabels = label(binary);
            
            charact_t *ch = characterize(NULL, src, nextLabels);
            
            //            NSLog(@"export count : %lu", (unsigned long)_exportCount);
            
            //            float seconds_elapsed = (float)_exportCount / 60;
            //            NSLog(@"seconds_elpased : %f", seconds_elapsed);
            
            int32_t bestRegId = overlappingreg(_previousReg, _previousLabels, nextLabels);
            
//            printf("bestRegId : %d\n", bestRegId);
            
            int isStatic = -1;
            
            
            rect_t bds;
            
            
            if ((bestRegId > 0) && (bestRegId <= ch->count))
            {
                regchar_t *bestReg = ch->data[bestRegId-1];
                
                bds.start.y = bestReg->bounds.start.y;
                bds.start.x = bestReg->bounds.start.x;
                bds.end.y = bestReg->bounds.end.y;
                bds.end.x = bestReg->bounds.end.x;
                
                if ((_exportCount % _motionImageFactor) == 0)
                {
                    int32_t comPixels = commonPixels(_previousMotionReg, _previousMotionLabels, bestReg, nextLabels);
                    
                    float comPixelsPercentage = (float)comPixels / _previousMotionReg->size;
                    
                    isStatic = comPixelsPercentage > _overlappingRate ? 1 : 0;
                    
                    free(_previousMotionReg);
                    _previousMotionReg = regcharcpy(bestReg);
                    
                    labfree(_previousMotionLabels);
                    _previousMotionLabels = labcpy(nextLabels);
                }
                
                free(_previousReg);
                _previousReg = regcharcpy(bestReg);
                labfree(_previousLabels);
                _previousLabels = nextLabels;
            }
            
            else
            {
                labfree(nextLabels);
                
                bds.start.y = 0;
                bds.start.x = 0;
                bds.end.y = 0;
                bds.end.x = 0;
            }
            
            TrackingObjectPosition *objPos = [[TrackingObjectPosition alloc] init];
            [objPos setBounds:bds];
            [objPos setImageId:_count];
            
            [_objectsPositionArray addObject:objPos];
            [_objectsMotionArray addObject:[NSNumber numberWithInt:isStatic]];
            
            gray8ifree(isubstract);
            binifree(binary);
            charactfree(ch);
            
            //
            
            NSUInteger rate = (NSUInteger)(_frameCount / 100);
            
            if (_count % rate == 0)
            {
                [_delegate didUpdateStatusWithProgress:0.0025 message:[NSString stringWithFormat:@"Tracking player.. (%lu / %lu)", (unsigned long)_count, (unsigned long)_frameCount]];
            }
        }
        
        gray8ifree(src);
    }
}

- (NSDictionary *)motionData
{
    NSDictionary *motionData = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:_objectsPositionArray, _objectsMotionArray, nil] forKeys:[NSArray arrayWithObjects:@"objectsPosition", @"objectsMotion", nil]];
    
    return motionData;
}

@end

@implementation TrackingObjectPosition

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _motionValue = -1;
        
        _bounds.start.x = 0;
        _bounds.end.x = 0;
        _bounds.start.y = 0;
        _bounds.end.y = 0;
    }
    
    return self;
}

@end
