//
//  UICoordinateSystemFactory.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICoordinateSystem2D.h"

@interface UICoordinateSystemFactory : NSObject

+ (UICoordinateSystem2D *)createDefaultCoordinateSystem2DViewWithFrame:(CGRect)frame;
+ (UICoordinateSystem2D *)createWhiteDefaultCoordinateSystem2DViewWithFrame:(CGRect)frame;


@end
