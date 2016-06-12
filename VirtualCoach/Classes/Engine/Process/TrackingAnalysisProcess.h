//
//  TrackingAnalysisProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtractorVideoDataOutputDelegate.h"
#import "Configurable.h"
#import "ImageTools.h"
#import "SimpleProcessStatusDelegate.h"

#include <core.h>
#include <io.h>
#include <labelling.h>
#include <arithmetic.h>
#include <characterization.h>
#include <geometry.h>
#include <drawing.h>

#include "charact_ext.h"

@interface TrackingAnalysisProcess : NSObject <ExtractorVideoDataOutputDelegate, Configurable>

@property (nonatomic) NSUInteger skippedFrameCount;
@property (nonatomic) CGFloat scale;
@property (nonatomic, assign) NSUInteger motionImageFactor;
@property (nonatomic, assign) CGFloat overlappingRate;

@property (nonatomic, weak) id <SimpleProcessStatusDelegate> delegate;

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo;
- (NSDictionary *)motionData;

@end

@interface TrackingObjectPosition : NSObject

@property (nonatomic, assign) unsigned long imageId;
@property (nonatomic, assign) rect_t bounds;
@property (nonatomic, assign) int motionValue;


@end
