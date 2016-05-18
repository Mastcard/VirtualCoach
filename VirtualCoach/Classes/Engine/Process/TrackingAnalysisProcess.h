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

#include <core.h>
#include <io.h>
#include <labelling.h>
#include <arithmetic.h>
#include <characterization.h>
#include <geometry.h>
#include <drawing.h>

#include "charact_ext.h"

@class UIImage;

@interface TrackingAnalysisProcess : NSObject <ExtractorVideoDataOutputDelegate, Configurable>

@property (nonatomic) CGFloat scale;

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo;

- (int *)retreiveRelevantImageSequences;

@end
