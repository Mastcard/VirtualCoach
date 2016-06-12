//
//  TrackingIrrelevantSequencesRemover.h
//  VirtualCoachAllProcess
//
//  Created by Romain Dubreucq on 10/06/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TrackingAnalysisProcess.h"

@interface TrackingIrrelevantSequencesRemover : NSObject

- (instancetype)initWithMotionArray:(NSMutableArray *)motionArray objectsPosition:(NSArray *)objectsPosition;
- (void)removeIrrelevantSequences;

@end
