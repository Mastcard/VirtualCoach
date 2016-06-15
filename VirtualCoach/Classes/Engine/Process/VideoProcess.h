//
//  VideoProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 10/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configurable.h"
#import "Process.h"

#import "SimpleProcessStatusDelegate.h"

#import "ExtractorVideoDataOutputProcess.h"
#import "TrackingAnalysisProcess.h"
#import "DataAnalysisProcess.h"
#import "TrackingRelevantSequencesBuilder.h"
#import "TrackingIrrelevantSequencesRemover.h"

#include "charact_ext.h"

@interface VideoProcess : NSObject <Configurable, Process, SimpleProcessStatusDelegate>

@property (nonatomic, strong) ExtractorVideoDataOutputProcess *extractorProcess;
@property (nonatomic, strong) TrackingAnalysisProcess *trackingAnalysisProcess;
@property (nonatomic, strong) DataAnalysisProcess *dataAnalysisProcess;

@property (nonatomic, weak) id <SimpleProcessStatusDelegate> delegate;

@property (nonatomic) NSUInteger skippedFrameCount;

@property (nonatomic) CGFloat scale;
@property (nonatomic) NSUInteger samplingCount;
@property (nonatomic) CGFloat overlappingRate;

@property (nonatomic) BOOL shouldDeleteIrrelevantSequences;

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo;

@end
