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
#import "ExtractorProcess.h"

#import "ExtractorVideoDataOutputProcess.h"
#import "TrackingAnalysisProcess.h"

#include <core.h>
#include <io.h>
#include <labelling.h>
#include <arithmetic.h>
#include <characterization.h>
#include <geometry.h>
#include <drawing.h>

#include "charact_ext.h"

@interface VideoProcess : NSObject <Configurable, Process>

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo;

@end
