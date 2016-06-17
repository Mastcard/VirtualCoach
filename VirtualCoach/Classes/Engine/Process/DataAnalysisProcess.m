//
//  DataAnalysisProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "DataAnalysisProcess.h"

@interface DataAnalysisProcess ()

@property (nonatomic, strong) NSDictionary *videoInfo;
@property (nonatomic, assign) uint8_t binaryThreshold;
@property (nonatomic, assign) rect_t playerBounds;
@property (nonatomic, assign) gray8i_t *referenceFrame;
@property (nonatomic, assign) BOOL canAnalyze;

@property (nonatomic, strong) NSArray *videoTrakingAnalysisInformations;

- (void)loadReferenceFrame;
- (void)loadTrackingInformations;

- (void)didOutputSampleBufferForProcess:(CMSampleBufferRef)sampleBuffer;
- (void)didOutputSampleBufferForTest:(CMSampleBufferRef)sampleBuffer;

//temp
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger videoTrakingAnalysisInformationsIndex;


// data analysis process
@property (nonatomic, assign) BOOL sequenceStarted;
@property (nonatomic, strong) Histogram *histogram;
@property (nonatomic, strong) KmeanEntryDataSet *entryDataset;

// optical flow properties

@property (nonatomic, assign) gray8i_t *firstFrame;
@property (nonatomic, assign) gray8i_t *secondFrame;
@property (nonatomic, assign) gray8i_t *thirdFrame;

@property (nonatomic, assign) rect_t firstFrameBounds;
@property (nonatomic, assign) rect_t secondFrameBounds;
@property (nonatomic, assign) rect_t thirdFrameBounds;

// miscalenneous

@property (nonatomic, assign) NSUInteger frameCount;

@property (nonatomic, assign) NSUInteger serviceCount;
@property (nonatomic, assign) NSUInteger forehandCount;
@property (nonatomic, assign) NSUInteger backhandCount;


@property (nonatomic, assign) int sequenceImageStart;
@property (nonatomic, assign) int sequenceImageEnd;

@end

@implementation DataAnalysisProcess

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo relevantSequences:(NSArray *)relevantSequences
{
    self = [super init];
    
    if (self)
    {
        _videoInfo = videoInfo;
        _videoTrakingAnalysisInformations = relevantSequences;
        _count = 0;
        _videoTrakingAnalysisInformationsIndex = 0;
        _frameCount = 0;
        
        _serviceCount = 0;
        _forehandCount = 0;
        _backhandCount = 0;
        
        _firstFrame = NULL;
        _secondFrame = NULL;
        _thirdFrame = NULL;
        
        
        //tmp
        _entryDatasetsArray = [[NSMutableArray alloc] init];
        
        _sequenceStarted = 0;
        _sequenceStarted = 0;
    }
    
    return self;
}

- (void)loadReferenceFrame
{
    NSString *referenceFramePath = [_videoInfo objectForKey:@"referenceFramePath"];
    
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
    _binaryThreshold = (uint8_t)((NSNumber *)[_videoInfo objectForKey:@"binaryThreshold"]).unsignedCharValue;
}

- (void)setup
{
    [self loadReferenceFrame];
    [self loadTrackingInformations];
    
    _histogram = [[Histogram alloc] init];
    _entryDataset = [[KmeanEntryDataSet alloc] init];
    
    _canAnalyze = YES;
}

- (void)didOutputSampleBufferForProcess:(CMSampleBufferRef)sampleBuffer
{
    if (_canAnalyze)
    {
        //temp
        _count++;
        
        if (_count >= _skippedFrameCount)
        {
            NSDictionary *imageDict = [_videoTrakingAnalysisInformations objectAtIndex:_videoTrakingAnalysisInformationsIndex];
            
            NSNumber *imageId = [imageDict objectForKey:@"imageId"];
            
            if (_count == imageId.unsignedIntValue)
            {
                _videoTrakingAnalysisInformationsIndex++;
                
                NSNumber *moves = [imageDict objectForKey:@"moves"];
                
                if (moves.intValue == 1)
                {
                    CGImageRef rgbImage = [ImageTools cgImageFromSampleBuffer:sampleBuffer];
                    CGImageRef rgbImageScaled = [ImageTools scaleCgimage:rgbImage scale:_scale];
                    
                    gray8i_t *src = [ImageTools cgImageToGrayImage:rgbImageScaled];
                    
                    CGImageRelease(rgbImage);
                    CGImageRelease(rgbImageScaled);
                    
                    rect_t playerBounds;
                    
                    if (_sequenceStarted)       // sequence continues
                    {
                        // get rect coordinates
                        
                        NSNumber *startX = [imageDict objectForKey:@"start.x"];
                        NSNumber *startY = [imageDict objectForKey:@"start.y"];
                        NSNumber *endX = [imageDict objectForKey:@"end.x"];
                        NSNumber *endY = [imageDict objectForKey:@"end.y"];
                        
                        // initializing rect_t with rect coordinates
                        
                        playerBounds.start.x = startX.unsignedIntValue;
                        playerBounds.end.x = endX.unsignedIntValue;
                        playerBounds.start.y = startY.unsignedIntValue;
                        playerBounds.end.y = endY.unsignedIntValue;
                        
                        if (_secondFrame == NULL)
                        {
                            _secondFrame = src;
                            _secondFrameBounds = playerBounds;
                        }
                        
                        else
                        {
                            if (_thirdFrame == NULL)
                            {
                                _thirdFrame = src;
                                _thirdFrameBounds = playerBounds;
                            }
                            
                            // optical flow
                            
                            vect2darray_t *speedVectors1 = opticalflow(_firstFrame, _secondFrame);
                            
                            double u = 0, v = 0;
                            
                            for (NSUInteger y = _secondFrameBounds.start.y; y < _secondFrameBounds.end.y; y++)
                            {
                                for (NSUInteger x = _secondFrameBounds.start.x; x < _secondFrameBounds.end.x; x++)
                                {
                                    unsigned long idx = PXL_IDX(src->width, x, y);
                                    
                                    u = speedVectors1->data[idx].x;
                                    v = speedVectors1->data[idx].y;
                                    
                                    speedVectors1->data[idx].x = (_firstFrame->data[idx] > _binaryThreshold) * u;
                                    speedVectors1->data[idx].y = (_firstFrame->data[idx] > _binaryThreshold) * v;
                                }
                            }
                            
                            // optical flow
                            
                            vect2darray_t *speedVectors2 = opticalflow(_secondFrame, _thirdFrame);
                            
                            double w = 0, z = 0;
                            
                            for (NSUInteger y = _thirdFrameBounds.start.y; y < _thirdFrameBounds.end.y; y++)
                            {
                                for (NSUInteger x = _thirdFrameBounds.start.x; x < _thirdFrameBounds.end.x; x++)
                                {
                                    unsigned long idx = PXL_IDX(src->width, x, y);
                                    
                                    w = speedVectors2->data[idx].x;
                                    z = speedVectors2->data[idx].y;
                                    
                                    speedVectors2->data[idx].x = (_secondFrame->data[idx] > _binaryThreshold) * w;
                                    speedVectors2->data[idx].y = (_secondFrame->data[idx] > _binaryThreshold) * z;
                                }
                            }
                            
                            [_histogram generateHistogramFromSpeedVector:speedVectors1 betweenInterval:playerBounds andWithImageWidth:src->width];
                            [_histogram generateHistogramFromSpeedVector:speedVectors2 betweenInterval:playerBounds andWithImageWidth:src->width];
                            
                            [_entryDataset addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:playerBounds andWithImageWidth:src->width];
                            
                            gray8ifree(_firstFrame);
                            _firstFrame = NULL;
                            gray8ifree(_secondFrame);
                            _secondFrame = NULL;
                            
                            _firstFrame = _thirdFrame;
                            _thirdFrame = NULL;
                            
                            vect2darrfree(speedVectors1);
                            vect2darrfree(speedVectors2);
                            
                            _firstFrameBounds.start.x = 0;
                            _firstFrameBounds.start.y = 0;
                            _firstFrameBounds.end.x = 0;
                            _firstFrameBounds.end.y = 0;
                            
                            _secondFrameBounds.start.x = 0;
                            _secondFrameBounds.start.y = 0;
                            _secondFrameBounds.end.x = 0;
                            _secondFrameBounds.end.y = 0;
                            
                            _thirdFrameBounds.start.x = 0;
                            _thirdFrameBounds.start.y = 0;
                            _thirdFrameBounds.end.x = 0;
                            _thirdFrameBounds.end.y = 0;
                        }
                    }
                    
                    else                        // sequence starts
                    {
                        _sequenceStarted = YES;
                        
                        NSLog(@"Sequence starts at %f", (float)(_count / 60));
                        
                        //test
                        _firstFrame = src;
                        _firstFrameBounds = playerBounds;
                        //tmp
                        _sequenceImageStart = (int)(_count);
                    }
                }
                
                else
                {
                    if (_sequenceStarted)       // sequence ends
                    {
                        _sequenceStarted = NO;
                        
                        //test
                        _sequenceImageEnd = (int)(_count);
                        
                        // do
                        
                        NSString *foundMotion = [MotionDeduction recognizeTennisMotionWithHistogram:_histogram andLeftHanded:false];
                        
                        NSLog(@"Found motion : %@", foundMotion);
                        
                        if ([foundMotion isEqualToString:@"service"])
                            _serviceCount++;
                        
                        if ([foundMotion isEqualToString:@"forehand"])
                            _forehandCount++;
                        
                        if ([foundMotion isEqualToString:@"backhand"])
                            _backhandCount++;
                        
                        NSDictionary *dictEntryDataset = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:_entryDataset, [NSNumber numberWithInt:_sequenceImageStart], [NSNumber numberWithInt:_sequenceImageEnd], nil] forKeys:[NSArray arrayWithObjects:@"entryDataset", @"startSequenceImage", @"endSequenceImage", nil]];
                        
                        [_entryDatasetsArray addObject:dictEntryDataset];
                        
                        _histogram = nil;
                        _histogram = [[Histogram alloc] init];
                        
                        _entryDataset = nil;
                        _entryDataset = [[KmeanEntryDataSet alloc] init];
                        
                        NSLog(@"Sequence ends at %f", (float)(_count / 60));
                    }
                }
            }
        }
        
        NSUInteger rate = (NSUInteger)(_frameCount / 100);
        
        if (_count % rate == 0)
        {
            [_delegate didUpdateStatusWithProgress:0.0025 message:[NSString stringWithFormat:@"Analyzing motions.. (%lu / %lu)", (unsigned long)_count, (unsigned long)_frameCount]];
        }
    }
}

- (void)didOutputSampleBufferForTest:(CMSampleBufferRef)sampleBuffer
{
    if (_canAnalyze)
    {
        //temp
        _count++;
        
        NSString *imagePathExport = [@"/Users/iSeven/Desktop/adrien_video/export2/" stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.pgm", (unsigned long)_count]];
        
        NSDictionary *imageDict = [_videoTrakingAnalysisInformations objectAtIndex:_videoTrakingAnalysisInformationsIndex];
        NSNumber *imageId = [imageDict objectForKey:@"imageId"];
        
        CGImageRef rgbImage = [ImageTools cgImageFromSampleBuffer:sampleBuffer];
        CGImageRef rgbImageScaled = [ImageTools scaleCgimage:rgbImage scale:_scale];
        
        gray8i_t *src = [ImageTools cgImageToGrayImage:rgbImageScaled];
        
        CGImageRelease(rgbImage);
        CGImageRelease(rgbImageScaled);
        
        if (_count == imageId.unsignedIntValue)
        {
            _videoTrakingAnalysisInformationsIndex++;
            
            NSNumber *startX = [imageDict objectForKey:@"start.x"];
            NSNumber *startY = [imageDict objectForKey:@"start.y"];
            NSNumber *endX = [imageDict objectForKey:@"end.x"];
            NSNumber *endY = [imageDict objectForKey:@"end.y"];
            NSNumber *moves = [imageDict objectForKey:@"moves"];
            
            uint8_t c = moves.intValue == 1 ? 0 : 255;
            
            //NSLog(@"Image is concerned : %lu, (%d %d %d %d)", _count, startX.unsignedIntValue, startY.unsignedIntValue, endX.unsignedIntValue, endY.unsignedIntValue);
            
            rect_t bds;
            bds.start.y = startY.unsignedIntValue;
            bds.start.x = startX.unsignedIntValue;
            bds.end.y = endY.unsignedIntValue;
            bds.end.x = endX.unsignedIntValue;
            
            drawrctgray8i(src, bds, c);
        }
        
        pgmwrite(src, [imagePathExport cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
        
        gray8ifree(src);
    }
}

- (void)didEstimateFrameCount:(Float64)frameCount
{
    _frameCount = (NSUInteger)frameCount;
}

- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    //[self didOutputSampleBufferForTest:sampleBuffer];
    [self didOutputSampleBufferForProcess:sampleBuffer];
}





- (NSUInteger)serviceCount
{
    return _serviceCount;
}

- (NSUInteger)forehandCount
{
    return _forehandCount;
}

- (NSUInteger)backhandCount
{
    return _backhandCount;
}

@end
