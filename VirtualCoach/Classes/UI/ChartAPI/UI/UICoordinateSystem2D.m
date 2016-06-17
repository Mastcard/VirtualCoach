//
//  UICoordinateSystem2D.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICoordinateSystem2D.h"
#import "UIAxis.h"
#import "Axis.h"
#import <QuartzCore/CAShapeLayer.h>
//#import "NSBezierPath+BezierPathQuartzUtilities.h"


@interface UICoordinateSystem2D ()

@property (nonatomic) NSMutableArray *layers;


- (void)drawAxes;
- (void)drawUnitSeparators;
- (void)drawBackgroundPattern;
- (void)drawAxesIdentifiers;
- (void)drawTitlesLabel;

@end

@implementation UICoordinateSystem2D

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _wantsAbscissTitles = YES;
        _wantsOrdinateTitles = YES;
        
        self.margin = 20.f;
        self.backgroundColor = [UIColor clearColor];
        _axisTitlesTextColor = [UIColor blackColor];
        
        _layers = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frameRect coordinateSystem:(CoordinateSystem2D *)coordinateSystem
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        _wantsAbscissTitles = YES;
        _wantsOrdinateTitles = YES;
        
        self.margin = 20.f;
        self.backgroundColor = [UIColor clearColor];
        
        _axisTitlesTextColor = [UIColor blackColor];
        
        self.coordinateSystem = coordinateSystem;
        
        self.abscissAxis = [[UIAxis alloc] initWithFrame:CGRectZero axis:[_coordinateSystem.axes objectForKey:@"absciss"]];
        self.ordinateAxis = [[UIAxis alloc] initWithFrame:CGRectZero axis:[_coordinateSystem.axes objectForKey:@"ordinate"]];
        
        _layers = [NSMutableArray array];
    }
    
    return self;
}

- (void)setCoordinateSystem:(CoordinateSystem2D *)coordinateSystem
{
    _coordinateSystem = coordinateSystem;
    
    _abscissAxis = [[UIAxis alloc] initWithFrame:CGRectZero axis:[_coordinateSystem.axes objectForKey:@"absciss"]];
    _ordinateAxis = [[UIAxis alloc] initWithFrame:CGRectZero axis:[_coordinateSystem.axes objectForKey:@"ordinate"]];
}

/*
 *
 *  To optimize drawing, we can draw everything (except the curves) in one loop...
 *
 */

- (void)draw
{
    
    [self drawAxes];
    [self drawUnitSeparators];
    
    if (_wantsBackgroundPattern) [self drawBackgroundPattern];
    if (_wantsAxesName) [self drawAxesIdentifiers];
    
    [self drawTitlesLabel];
}

- (void)undraw
{
    for (CALayer *layer in _layers)
    {
        [layer removeFromSuperlayer];
    }
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)drawAxes
{
    /**
     *
     *  WE SHOULD CHECK IF THE AXES BOUNDS ARE STRICTLY POSITIVE, OTHERWISE WE HAVE TO CHANGE THE POSITION
     *
     **/
    
    // Draw absciss axis
    
    UIBezierPath *abscissPath = [UIBezierPath bezierPath];
    [abscissPath moveToPoint:CGPointMake(_margin, self.frame.size.height - _margin)];
    [abscissPath addLineToPoint:CGPointMake(self.frame.size.width - _margin,self.frame.size.height - _margin)];
    
    CAShapeLayer *abscissShapeLayer = [CAShapeLayer layer];
    abscissShapeLayer.path = [abscissPath CGPath];
    abscissShapeLayer.strokeColor = [self.abscissAxis.lineColor CGColor];
    abscissShapeLayer.lineWidth = self.abscissAxis.lineWidth.floatValue;
    
    [self.layer addSublayer:abscissShapeLayer];
    [_layers addObject:abscissShapeLayer];
    
    // Draw ordinate axis
    
    UIBezierPath *ordinatePath = [UIBezierPath bezierPath];
    [ordinatePath moveToPoint:CGPointMake(_margin, self.frame.size.height - _margin)];
    [ordinatePath addLineToPoint:CGPointMake(_margin, _margin)];
    
    CAShapeLayer *ordinateShapeLayer = [CAShapeLayer layer];
    ordinateShapeLayer.path = [ordinatePath CGPath];
    ordinateShapeLayer.strokeColor = [self.ordinateAxis.lineColor CGColor];
    ordinateShapeLayer.lineWidth = self.ordinateAxis.lineWidth.floatValue;
    
    [self.layer addSublayer:ordinateShapeLayer];
    [_layers addObject:ordinateShapeLayer];
}

- (void)drawUnitSeparators
{
    Axis *xAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"absciss"]);
    
    CGFloat unitIntervalX = xAxis.maxBound.floatValue / xAxis.unit.floatValue;
    CGFloat unitWidth = (self.frame.size.width - (_margin * 2)) / unitIntervalX;
    
    CGFloat currentXForSeparator = _margin + unitWidth;
    
    for (NSUInteger i = 1; i <= _abscissAxis.titles.count; i++)
    {
        UIBezierPath *abscissUnitPath = [UIBezierPath bezierPath];
        [abscissUnitPath moveToPoint:CGPointMake(currentXForSeparator, self.frame.size.height - _margin - (self.abscissAxis.unitSeparatorLineLength.floatValue / 2))];
        [abscissUnitPath addLineToPoint:CGPointMake(currentXForSeparator, self.frame.size.height - _margin + (self.abscissAxis.unitSeparatorLineLength.floatValue / 2))];
        
        CAShapeLayer *abscissUnitShapeLayer = [CAShapeLayer layer];
        abscissUnitShapeLayer.path = [abscissUnitPath CGPath];
        abscissUnitShapeLayer.strokeColor = [self.abscissAxis.lineColor CGColor];
        abscissUnitShapeLayer.lineWidth = self.abscissAxis.lineWidth.floatValue;
        
        [self.layer addSublayer:abscissUnitShapeLayer];
        [_layers addObject:abscissUnitShapeLayer];
        
        currentXForSeparator += unitWidth;
    }
    
    Axis *yAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"ordinate"]);
    
    CGFloat unitIntervalY = yAxis.maxBound.floatValue / yAxis.unit.floatValue;
    CGFloat unitHeight = (self.frame.size.height - (_margin * 2)) / unitIntervalY;
    CGFloat currentYForSeparator =  self.frame.size.height - 2*_margin ;
    
    for (NSUInteger i = 1; i <= _ordinateAxis.titles.count; i++)
    {
        UIBezierPath *ordinateUnitPath = [UIBezierPath bezierPath];
        [ordinateUnitPath moveToPoint:CGPointMake(_margin - (self.ordinateAxis.unitSeparatorLineLength.floatValue / 2), currentYForSeparator)];
        [ordinateUnitPath addLineToPoint:CGPointMake(_margin + (self.ordinateAxis.unitSeparatorLineLength.floatValue / 2), currentYForSeparator)];
        
        CAShapeLayer *ordinateUnitShapeLayer = [CAShapeLayer layer];
        ordinateUnitShapeLayer.path = [ordinateUnitPath CGPath];
        ordinateUnitShapeLayer.strokeColor = [self.ordinateAxis.lineColor CGColor];
        ordinateUnitShapeLayer.lineWidth = self.ordinateAxis.lineWidth.floatValue;
        
        [self.layer addSublayer:ordinateUnitShapeLayer];
        [_layers addObject:ordinateUnitShapeLayer];
        
        currentYForSeparator -= unitHeight;
    }
}

- (void)drawBackgroundPattern
{
    Axis *xAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"absciss"]);
    
    CGFloat unitIntervalX = xAxis.maxBound.floatValue / xAxis.unit.floatValue;
    CGFloat unitWidth = (self.frame.size.width - (_margin * 2)) / unitIntervalX;
    CGFloat currentXForSeparator = _margin + unitWidth;
    
    for (NSUInteger i = 1; i < xAxis.values.count; i++)
    {
        UIBezierPath *abscissUnitPath = [UIBezierPath bezierPath];
        [abscissUnitPath moveToPoint:CGPointMake(currentXForSeparator, _margin)];
        [abscissUnitPath addLineToPoint:CGPointMake(currentXForSeparator, self.frame.size.height - _margin)];
        
        CAShapeLayer *abscissUnitShapeLayer = [CAShapeLayer layer];
        abscissUnitShapeLayer.path = [abscissUnitPath CGPath];
        abscissUnitShapeLayer.strokeColor = [self.backgroundPatternLineColor CGColor];
        abscissUnitShapeLayer.lineWidth = 0.5;
        
        [self.layer addSublayer:abscissUnitShapeLayer];
        [_layers addObject:abscissUnitShapeLayer];
        
        currentXForSeparator += unitWidth;
    }
    
    Axis *yAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"ordinate"]);
    
    CGFloat unitIntervalY = yAxis.maxBound.floatValue / yAxis.unit.floatValue;
    CGFloat unitHeight = (self.frame.size.height - (_margin * 2)) / unitIntervalY;
    CGFloat currentYForSeparator = _margin + unitHeight;
    
    for (NSUInteger i = 1; i < yAxis.values.count; i++)
    {
        UIBezierPath *ordinateUnitPath = [UIBezierPath bezierPath];
        [ordinateUnitPath moveToPoint:CGPointMake(_margin, currentYForSeparator)];
        [ordinateUnitPath addLineToPoint:CGPointMake(self.frame.size.width - _margin, currentYForSeparator)];
        
        CAShapeLayer *ordinateUnitShapeLayer = [CAShapeLayer layer];
        ordinateUnitShapeLayer.path = [ordinateUnitPath CGPath];
        ordinateUnitShapeLayer.strokeColor = [self.backgroundPatternLineColor CGColor];
        ordinateUnitShapeLayer.lineWidth = 0.5;
        
        [self.layer addSublayer:ordinateUnitShapeLayer];
        [_layers addObject:ordinateUnitShapeLayer];
        
        currentYForSeparator += unitHeight;
    }
}

- (void)drawAxesIdentifiers
{
    
}

- (void)drawTitlesLabel
{
    
    if (_wantsAbscissTitles)
    {
        Axis *xAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"absciss"]);
        
        CGFloat unitIntervalX = xAxis.maxBound.floatValue / xAxis.unit.floatValue;
        CGFloat unitWidth = (self.frame.size.width - (_margin * 2)) / unitIntervalX;
        CGFloat currentXForSeparator = _margin + unitWidth;
        
        for (NSUInteger i = 0; i < _abscissAxis.titles.count; i++)
        {
            UIBaseLabel *label = [[UIBaseLabel alloc] init];
            [label setText:(NSString *)[_abscissAxis.titles objectAtIndex:i]];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.f]];
            label.textColor = _axisTitlesTextColor;
            
            [label resizeToFitText];
            
            currentXForSeparator -= (label.frame.size.width / 2);
            
            [label setFrame:CGRectMake(currentXForSeparator, self.frame.size.height - _margin + (self.abscissAxis.unitSeparatorLineLength.floatValue / 2), label.frame.size.width, label.frame.size.height)];
            [self addSubview:label];
            
            currentXForSeparator += (label.frame.size.width / 2);
            currentXForSeparator += unitWidth;
        }
    }
    
    if (_wantsOrdinateTitles)
    {
        Axis *yAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"ordinate"]);
        
        CGFloat unitIntervalY = yAxis.maxBound.floatValue / yAxis.unit.floatValue;
        CGFloat unitHeight = (self.frame.size.height - (_margin * 2)) / unitIntervalY;
        CGFloat currentYForSeparator = self.frame.size.height - (2 * _margin);
        
        for (NSUInteger i = 0; i < _ordinateAxis.titles.count; i++)
        {
            UIBaseLabel *label = [[UIBaseLabel alloc] init];
            [label setText:(NSString *)[_ordinateAxis.titles objectAtIndex:i]];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.f]];
            label.textColor = _axisTitlesTextColor;
            
            [label resizeToFitText];
            
            currentYForSeparator -= (label.frame.size.height / 2);
            
            [label setFrame:CGRectMake(_margin - ((self.ordinateAxis.unitSeparatorLineLength.floatValue / 1.75) + label.frame.size.width), currentYForSeparator, label.frame.size.width, label.frame.size.height)];
            [self addSubview:label];
            
            currentYForSeparator += (label.frame.size.height / 2);
            currentYForSeparator -= unitHeight;
        }
    }
    
    if (_titleLabel.attributedText.length > 0)
    {
        [_titleLabel resizeToFitText];
        
        [_titleLabel setFrame:CGRectMake(self.frame.size.width - _titleLabel.frame.size.width, 0, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
        [self addSubview:_titleLabel];
    }
}

- (void)drawCurve:(UICurve *)curve
{
    [curve setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [curve setBackgroundColor:[UIColor clearColor]];
    
    
    Axis *xAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"absciss"]);
    Axis *yAxis = ((Axis *)[_coordinateSystem.axes objectForKey:@"ordinate"]);
    
    CGFloat usefulWidth = curve.frame.size.width - (_margin * 2);
    CGFloat usefulHeight = curve.frame.size.height - (_margin * 2);
    
    CGFloat unitIntervalX = xAxis.maxBound.floatValue / xAxis.unit.floatValue;
    CGFloat unitIntervalY = yAxis.maxBound.floatValue / yAxis.unit.floatValue;
    
    CGFloat unitWidth = usefulWidth / unitIntervalX;
    CGFloat unitHeight = usefulHeight / unitIntervalY;
    
    NSUInteger counter = 0;
    UIBezierPath *curvePath = [UIBezierPath bezierPath];
    
    CGFloat lastX = 0;
    CGFloat lastY = 0;
    
    BOOL hasValues = NO;
    
    for (NSString *key in [curve.curve.values allKeys])
    {
        if ([curve.curve.values objectForKey:key] != [NSNull null])
        {
            hasValues = YES;
            break;
        }
    }
    
    if (curve.curve.values.count > 0 && hasValues)
    {
        BOOL lastValueNull = NO;
        
        for (NSUInteger i = 0; i < _abscissAxis.titles.count; i++)
        {
            NSNumber *value = [curve.curve.values objectForKey:[_abscissAxis.titles objectAtIndex:i]];
            
            NSUInteger index = ([_abscissAxis.titles indexOfObject:[_abscissAxis.titles objectAtIndex:i]] + 1);
            
            CGFloat x = 0.0;
            CGFloat y = 0.0;
            
            if ([value isEqual:[NSNull null]])
            {
                lastValueNull = YES;
                
                [curvePath moveToPoint:CGPointMake(lastX, lastY)];
                
                CAShapeLayer *curveTemporaryShapeLayer = [CAShapeLayer layer];
                curveTemporaryShapeLayer.path = [curvePath CGPath];
                curveTemporaryShapeLayer.strokeColor = [curve.lineColor CGColor];
                curveTemporaryShapeLayer.lineWidth = curve.lineWidth.floatValue;
                curveTemporaryShapeLayer.fillColor = [UIColor clearColor].CGColor;
                
                [curvePath closePath];
                
                if (curve.drawLine)
                {
                    [curve.layer addSublayer:curveTemporaryShapeLayer];
                    [curve.objectLayers addObject:curveTemporaryShapeLayer];
                }
                
                curvePath = [UIBezierPath bezierPath];
            }
            
            else
            {
                x = (_margin + (index * unitWidth)) / xAxis.unit.floatValue;
                y = (curve.frame.size.height - (_margin)) - (((value.intValue/ yAxis.unit.floatValue) * unitHeight) );
                
                if (counter == 0 || lastValueNull)
                {
                    [curvePath moveToPoint:CGPointMake(x, y)];
                    lastValueNull = NO;
                }
                
                
                else
                {
                    [curvePath addLineToPoint:CGPointMake(x, y)];
                    lastX = x;
                    lastY = y;
                }
            }
            
            if (curve.drawPoints)
            {
                CAShapeLayer *circleShapeLayer = [CAShapeLayer layer];
                circleShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x - 2, y - 2, 4, 4)].CGPath;;
                circleShapeLayer.strokeColor = [curve.lineColor CGColor];
                circleShapeLayer.lineWidth = curve.lineWidth.floatValue;
                circleShapeLayer.fillColor = [curve.lineColor CGColor];
                
                [curve.layer addSublayer:circleShapeLayer];
                [curve.objectLayers addObject:circleShapeLayer];
            }
            
            counter++;
        }
        
        [curvePath moveToPoint:CGPointMake(lastX, lastY)];
        
        CAShapeLayer *curveShapeLayer = [CAShapeLayer layer];
        curveShapeLayer.frame = curve.frame;
        curveShapeLayer.path = [curvePath CGPath];
        curveShapeLayer.strokeColor = [curve.lineColor CGColor];
        curveShapeLayer.lineWidth = curve.lineWidth.floatValue;
        curveShapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        [curvePath closePath];
        
        if (curve.drawLine)
        {
            [curve.layer addSublayer:curveShapeLayer];
            [curve.objectLayers addObject:curveShapeLayer];
        }
    }
    
    [self addSubview:curve];
}

- (void)removeCurve:(UICurve *)curve
{
    for (UIView *subview in self.subviews)
    {
        if ([curve isEqual:subview])
            [subview removeFromSuperview];
    }
}

- (void)removeAllCurves
{
    for (UIView *subview in self.subviews)
    {
        if ([subview isMemberOfClass:[UICurve class]])
            [subview removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
