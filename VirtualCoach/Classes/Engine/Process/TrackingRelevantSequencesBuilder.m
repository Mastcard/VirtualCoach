//
//  TrackingRelevantSequencesBuilder.m
//  VirtualCoachAllProcess
//
//  Created by Romain Dubreucq on 09/06/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import "TrackingRelevantSequencesBuilder.h"

@interface TrackingRelevantSequencesBuilder ()

@property (nonatomic) NSUInteger motionImageFactor;
@property (nonatomic) NSArray *partialSequences;
@property (nonatomic, strong) NSMutableArray *relevantSequences;

- (NSMutableArray *)buildRelevantSequencesFromPartial;

@end

@implementation TrackingRelevantSequencesBuilder

- (instancetype)initWithPartialMotionArray:(NSArray *)array motionImageFactor:(NSUInteger)motionImageFactor
{
    self = [super init];
    
    if (self)
    {
        _motionImageFactor = motionImageFactor;
        _partialSequences = array;
    }
    
    return self;
}

- (NSMutableArray *)buildRelevantSequencesFromPartial
{
    NSMutableArray *finalObjectsMotion = [_partialSequences mutableCopy];
    
    NSUInteger currentMarkerIndex;
    NSUInteger previousMarkerIndex = 0;
    int previousMarker = 1;
    
    for (NSUInteger i = _motionImageFactor-1; i < finalObjectsMotion.count; i += _motionImageFactor)
    {
        currentMarkerIndex = i;
        
        int currentMarker = ((NSNumber *)[finalObjectsMotion objectAtIndex:currentMarkerIndex]).intValue;
        
        //        NSLog(@"currentMarkerIndex : %lu, previousMarkerIndex : %lu", (unsigned long)currentMarkerIndex, (unsigned long)previousMarkerIndex);
//        NSLog(@"currentMarker : %d, previousMarker : %d (%d, %d)", currentMarker, previousMarker, (int)currentMarkerIndex, (int)previousMarkerIndex);
        
        int newValue = (currentMarker == 0 && previousMarker == 0) ? 0 : 1;
        
        for (NSUInteger k = previousMarkerIndex + 1; k < currentMarkerIndex; k++)
            [finalObjectsMotion replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:newValue]];
        
        previousMarker = currentMarker;
        previousMarkerIndex = currentMarkerIndex;
    }
    
    return finalObjectsMotion;
}

- (NSMutableArray *)removeIrrelevantSequences
{
    
    return nil;
}

- (void)buildRelevantSequences
{
    _relevantSequences = [self buildRelevantSequencesFromPartial];
}

- (NSMutableArray *)retreiveRelevantSequences
{
    return _relevantSequences;
}

@end
