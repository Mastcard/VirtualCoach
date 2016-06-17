//
//  TrackingIrrelevantSequencesRemover.m
//  VirtualCoachAllProcess
//
//  Created by Romain Dubreucq on 10/06/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import "TrackingIrrelevantSequencesRemover.h"

@interface TrackingIrrelevantSequencesRemover ()

@property (nonatomic) NSMutableArray *originalMotionArray;
@property (nonatomic) NSArray *originalObjectsPosition;

- (void)removeIrrelevantSequencesWithSurface;
- (void)removeIrrelevantSequencesWithDimensions;

- (void)removeIrrelevantSequencesFromComplete;

@end

@implementation TrackingIrrelevantSequencesRemover

- (instancetype)initWithMotionArray:(NSMutableArray *)motionArray objectsPosition:(NSArray *)objectsPosition
{
    self = [super init];
    
    if (self)
    {
        _originalMotionArray = motionArray;
        _originalObjectsPosition = objectsPosition;
    }
    
    return self;
}

- (void)removeIrrelevantSequencesWithSurface
{
    BOOL relevantSequence = NO;
    
    uint32_t surfaceAcc = 0;
    uint32_t relevantFrameCount = 0;
    
    NSMutableArray *surfaceArray = [NSMutableArray array];
    
    NSUInteger sequence_start = -1, sequence_end = -1;
    
    for (NSUInteger i = 1; i < _originalMotionArray.count; i++)
    {
        NSNumber *motionNumber = ((NSNumber *)[_originalMotionArray objectAtIndex:i]);
        
//        NSLog(@"motionNumber %d", motionNumber.intValue);
        
        if (motionNumber.intValue == 1)
        {
            // calculates surface
            
            TrackingObjectPosition *top = (TrackingObjectPosition *)[_originalObjectsPosition objectAtIndex:i];
            rect_t bounds = top.bounds;
            
            uint32_t surface = (bounds.end.x - bounds.start.x) * (bounds.end.y - bounds.start.y);
            
//            NSLog(@"surface %d", surface);
            
            [surfaceArray addObject:[NSNumber numberWithUnsignedInt:surface]];
            
            surfaceAcc += surface;
            
            relevantFrameCount++;
            
            if (!relevantSequence) // relevant sequence starts
            {
                relevantSequence = YES;
                sequence_start = i;
                NSLog(@"Sequence starts at %f",  (float)((float)(i+200) / 60));
                //NSLog(@"img, %d sec %f", (int)i + 200, (float)((float)i / 60));
            }
            
        }
        
        else if (motionNumber.intValue == 0)
        {
            if (relevantSequence) // relevant sequence ends
            {
                sequence_end = i;
                // calculates the rect surface average
                
                uint32_t surfaceAverage = (uint32_t)(surfaceAcc / relevantFrameCount);
                
                //NSLog(@"surfaceAverage %d, relevantFrameCount %d", surfaceAverage, relevantFrameCount);
                //                NSLog(@"width average %d, relevantFrameCount %d", widthAverage, relevantFrameCount);
                //                NSLog(@"height average %d, relevantFrameCount %d", heightAverage, relevantFrameCount);
                
                // calculates the variance of the rect surface
                
                float variance_acc = 0.f;
                
                for (NSUInteger j = 0; j < surfaceArray.count; j++)
                {
                    //NSLog(@"sur : %d, surfaceAverage : %d", ((NSNumber *)[surfaceArray objectAtIndex:j]).unsignedIntValue, surfaceAverage);
                    int32_t tmp = abs((int)(((NSNumber *)[surfaceArray objectAtIndex:j]).unsignedIntValue - surfaceAverage));
                    
                    //NSLog(@"surface - surfaceAverage = %f", tmp);
                    
                    variance_acc += powf(tmp, 2.0);
                }
                
                
                //NSLog(@"Variance acc : %f", variance_acc);
                
                float variance = variance_acc / relevantFrameCount;

                float sd = sqrtf(variance);
                
                int standard_deviation_threshold = 300;
                
                if (sd < standard_deviation_threshold)
                {
                    for (NSUInteger j = sequence_start; j <= sequence_end; j++)
                        [_originalMotionArray replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:0]];
                }
                
                NSLog(@"Ecart type %f", sd);
                
                NSLog(@"Sequence ends at %f",  (float)((float)(i+200) / 60));
                
                // reset everything
                
                surfaceAcc = 0;
                relevantFrameCount = 0;
                relevantSequence = NO;
                [surfaceArray removeAllObjects];
            }
        }
    }
}

- (void)removeIrrelevantSequencesWithDimensions
{
    BOOL relevantSequence = NO;
    
    uint32_t widthAcc = 0, heightAcc = 0;
    uint32_t relevantFrameCount = 0;
    
    NSMutableArray *widthArray = [NSMutableArray array];
    NSMutableArray *heightArray = [NSMutableArray array];
    
    NSUInteger sequence_start = -1, sequence_end = -1;
    
    for (NSUInteger i = 1; i < _originalMotionArray.count; i++)
    {
        NSNumber *motionNumber = ((NSNumber *)[_originalMotionArray objectAtIndex:i]);
        
        //NSLog(@"motionNumber %d", motionNumber.intValue);
        
        if (motionNumber.intValue == 1)
        {
            // calculates dimensions
            
            TrackingObjectPosition *top = (TrackingObjectPosition *)[_originalObjectsPosition objectAtIndex:i];
            rect_t bounds = top.bounds;
            
            uint32_t width = (bounds.end.x - bounds.start.x);
            uint32_t height = (bounds.end.y - bounds.start.y);
            
//            NSLog(@"width %d, height %d at frame %d", width, height, (int)i + 200);
            
            //NSLog(@"surface %d", surface);
            
            [widthArray addObject:[NSNumber numberWithUnsignedInt:width]];
            [heightArray addObject:[NSNumber numberWithUnsignedInt:height]];
            
            widthAcc += width;
            heightAcc += height;
            
            relevantFrameCount++;
            
            if (!relevantSequence) // relevant sequence starts
            {
                relevantSequence = YES;
                sequence_start = i;
                //NSLog(@"img, %d sec %f", (int)i + 200, (float)((float)i / 60));
            }
            
        }
        
        else if (motionNumber.intValue == 0)
        {
            if (relevantSequence) // relevant sequence ends
            {
                sequence_end = i;
                
                uint32_t widthAverage = (uint32_t)(widthAcc / relevantFrameCount);
                uint32_t heightAverage = (uint32_t)(heightAcc / relevantFrameCount);
                
                // calculates the variance of the rect surface
                
                float width_variance_acc = 0.f, height_variance_acc = 0;
                
                for (NSUInteger j = 0; j < widthArray.count; j++)
                {
                    int32_t width_tmp = abs((int)(((NSNumber *)[widthArray objectAtIndex:j]).unsignedIntValue - widthAverage));
                    
                    int32_t height_tmp = abs((int)(((NSNumber *)[heightArray objectAtIndex:j]).unsignedIntValue - heightAverage));
                    
                    width_variance_acc += powf(width_tmp, 2.0);
                    height_variance_acc += powf(height_tmp, 2.0);
                }
                
                
                float width_variance = width_variance_acc / relevantFrameCount;
                float height_variance = height_variance_acc / relevantFrameCount;
                
                float width_standard_deviation = sqrtf(width_variance);
                float height_standard_deviation = sqrtf(height_variance);
                
                int standard_deviation_threshold = 7;
                
                // or 400 for surface
                
                if ((width_standard_deviation < standard_deviation_threshold) && (width_standard_deviation < standard_deviation_threshold))
                {
                    for (NSUInteger j = sequence_start; j <= sequence_end; j++)
                        [_originalMotionArray replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:0]];
                }
                
                NSLog(@"Width deviation %f at %f seconds", width_standard_deviation, (float)(i / 60));
                NSLog(@"Height deviation %f at %f seconds", height_standard_deviation, (float)(i / 60));
                
                // reset everything
                
                widthAcc = 0;
                heightAcc = 0;
                relevantFrameCount = 0;
                relevantSequence = NO;
                //[surfaceArray removeAllObjects];
                [widthArray removeAllObjects];
                [heightArray removeAllObjects];
            }
        }
    }
}

- (void)removeIrrelevantSequencesFromComplete
{
    [self removeIrrelevantSequencesWithSurface];
    //[self removeIrrelevantSequencesWithDimensions];
}

- (void)removeIrrelevantSequences
{
    [self removeIrrelevantSequencesFromComplete];
}

@end
