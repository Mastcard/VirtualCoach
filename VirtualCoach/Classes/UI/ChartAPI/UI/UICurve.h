//
//  UICurve.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Curve.h"

@interface UICurve : UIView

@property (nonatomic) Curve *curve;

@property (nonatomic) BOOL drawLine;

@property (nonatomic) BOOL drawPoints;

@property (nonatomic) NSNumber *lineWidth;

@property (nonatomic) UIColor *lineColor;

@property (nonatomic) NSMutableArray *objectLayers;

- (instancetype)initWithFrame:(CGRect)frameRect curve:(Curve *)curve;
- (void)undraw;

@end
