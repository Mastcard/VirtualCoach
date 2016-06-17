//
//  UICurve.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICurve.h"

@implementation UICurve

- (instancetype)initWithFrame:(CGRect)frameRect curve:(Curve *)curve
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        _curve = curve;
        _drawLine = YES;
        _drawPoints = NO;
        _lineWidth = [NSNumber numberWithInt:3];
        _lineColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end

