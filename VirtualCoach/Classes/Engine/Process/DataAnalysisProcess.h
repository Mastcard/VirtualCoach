//
//  DataAnalysisProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "ExtractorVideoDataOutputDelegate.h"
#import "Configurable.h"
#import "ImageTools.h"
#import "Histogram.h"
#import "MotionDeduction.h"

#import "SimpleProcessStatusDelegate.h"

#include <core.h>
#include <io.h>
#include <labelling.h>
#include <arithmetic.h>
#include <characterization.h>
#include <geometry.h>
#include <drawing.h>
#include <opticalflow.h>

@interface DataAnalysisProcess : NSObject <ExtractorVideoDataOutputDelegate, Configurable>

@property (nonatomic) NSUInteger skippedFrameCount;
@property (nonatomic) CGFloat scale;

@property (nonatomic, weak) id <SimpleProcessStatusDelegate> delegate;

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo relevantSequences:(NSArray *)relevantSequences;

//temp
- (NSUInteger)serviceCount;
- (NSUInteger)forehandCount;
- (NSUInteger)backhandCount;

@end
