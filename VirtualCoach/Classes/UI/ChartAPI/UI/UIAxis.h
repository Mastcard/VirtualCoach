//
//  UIAxis.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Axis.h"

@interface UIAxis : UIView

@property (nonatomic) Axis *axis;

@property (nonatomic) NSNumber *lineWidth;

@property (nonatomic) UIColor *lineColor;

@property (nonatomic) NSNumber *unitIntervalLength;

@property (nonatomic) NSNumber *unitSeparatorLineLength;

@property (nonatomic) NSNumber *titleUnit;

@property (nonatomic) NSNumber *orientationAngle;

@property (nonatomic) NSNumber *titleInterval;

@property (nonatomic) NSArray *titles;

- (instancetype)initWithFrame:(CGRect)frameRect axis:(Axis *)axis;
- (void)undraw;

@end
