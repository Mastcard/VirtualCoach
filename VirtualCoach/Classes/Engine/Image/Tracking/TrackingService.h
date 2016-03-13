//
//  TrackingService.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <core.h>
#include <characterization.h>

@interface TrackingService : NSObject

+ (int32_t)trackRegion:(regchar_t *)reg byOverlapping:(labels_t *)labels withReferenceLabels:(labels_t *)reflabels;

@end
