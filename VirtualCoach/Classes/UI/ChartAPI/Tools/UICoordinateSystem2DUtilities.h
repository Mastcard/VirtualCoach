//
//  UICoordinateSystem2DUtilities.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICoordinateSystem2D.h"

@interface UICoordinateSystem2DUtilities : NSObject

+ (NSString *)titleForTouchLocation:(CGPoint)locationPoint inCoordinateSystem:(UICoordinateSystem2D *)coordinateSystem;

@end
