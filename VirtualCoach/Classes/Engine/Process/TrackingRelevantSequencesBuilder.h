//
//  TrackingRelevantSequencesBuilder.h
//  VirtualCoachAllProcess
//
//  Created by Romain Dubreucq on 09/06/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackingRelevantSequencesBuilder : NSObject

- (instancetype)initWithPartialMotionArray:(NSArray *)array motionImageFactor:(NSUInteger)motionImageFactor;
- (void)buildRelevantSequences;
- (NSMutableArray *)retreiveRelevantSequences;

@end
