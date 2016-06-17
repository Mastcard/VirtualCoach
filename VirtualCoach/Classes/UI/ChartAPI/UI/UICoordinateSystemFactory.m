//
//  UICoordinateSystemFactory.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICoordinateSystemFactory.h"
#import "CoordinateSystem2D.h"
#import "Axis.h"
#import "UICoordinateSystem2D.h"
#import "NSOrderedDictionary.h"

@implementation UICoordinateSystemFactory

+ (UICoordinateSystem2D *)createDefaultCoordinateSystem2DViewWithFrame:(CGRect)frame
{
    CoordinateSystem2D *cs = [[CoordinateSystem2D alloc] init];
    
    Axis *absciss = [cs.axes objectForKey:@"absciss"];
    [absciss setUnit:[NSNumber numberWithInt:1]];
    [absciss setMinBound:[NSNumber numberWithInt:0]];
    [absciss setMaxBound:[NSNumber numberWithInt:12]];
    
    Axis *ordinate = [cs.axes objectForKey:@"ordinate"];
    [ordinate setUnit:[NSNumber numberWithInt:10]];
    [ordinate setMinBound:[NSNumber numberWithInt:0]];
    [ordinate setMaxBound:[NSNumber numberWithInt:100]];
    
    [cs prepare];
    
    UICoordinateSystem2D *uics = [[UICoordinateSystem2D alloc] initWithFrame:frame coordinateSystem:cs];
    //uics.backgroundColor = [UIColor greenColor];
    uics.margin = 50.f;
    uics.wantsBackgroundPattern = YES;
    uics.wantsAxesName = YES;
    uics.backgroundPatternLineColor = [UIColor colorWithRed:(80.f / 255.f) green:(80.f / 255.f) blue:(80.f / 255.f) alpha:0.2];
    
    uics.abscissAxis.titleUnit = [NSNumber numberWithInt:1];
    uics.abscissAxis.lineColor = [UIColor blackColor];
    uics.abscissAxis.titles = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    uics.abscissAxis.lineWidth = [NSNumber numberWithInt:2];
    uics.abscissAxis.unitSeparatorLineLength = [NSNumber numberWithInt:8];
    uics.abscissAxis.titleInterval = [NSNumber numberWithInt:1];
    
    uics.ordinateAxis.titleUnit = [NSNumber numberWithInt:1];
    uics.ordinateAxis.lineColor = [UIColor blackColor];
    uics.ordinateAxis.titles = [NSArray arrayWithObjects:@"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90", @"100", nil];
    uics.ordinateAxis.lineWidth = [NSNumber numberWithInt:2];
    uics.ordinateAxis.unitSeparatorLineLength = [NSNumber numberWithInt:8];
    uics.ordinateAxis.titleInterval = [NSNumber numberWithInt:1];
    
    [uics draw];
    
    Curve *curve = [[Curve alloc] init];
    
    curve.values = [NSOrderedDictionary dictionaryWithObjects:
                    [NSArray arrayWithObjects:[NSNumber numberWithInt:12], [NSNumber numberWithInt:27], [NSNull null], [NSNull null], [NSNumber numberWithInt:50], [NSNumber numberWithInt:60], [NSNumber numberWithInt:73], [NSNumber numberWithInt:88], [NSNumber numberWithInt:19], [NSNumber numberWithInt:87], [NSNull null], [NSNumber numberWithInt:63], nil]
                                                      forKeys:
                    [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil]];
    
    
    UICurve *uicurve = [[UICurve alloc] initWithFrame:CGRectZero curve:curve];
    uicurve.lineColor = [UIColor grayColor];
    uicurve.drawPoints = YES;
    uicurve.lineWidth = [NSNumber numberWithFloat:0.3];
    
    [uics drawCurve:uicurve];
    
    return uics;
}

+ (UICoordinateSystem2D *)createWhiteDefaultCoordinateSystem2DViewWithFrame:(CGRect)frame
{
    CoordinateSystem2D *cs = [[CoordinateSystem2D alloc] init];
    
    Axis *absciss = [cs.axes objectForKey:@"absciss"];
    [absciss setUnit:[NSNumber numberWithInt:1]];
    [absciss setMinBound:[NSNumber numberWithInt:0]];
    [absciss setMaxBound:[NSNumber numberWithInt:12]];
    
    Axis *ordinate = [cs.axes objectForKey:@"ordinate"];
    [ordinate setUnit:[NSNumber numberWithInt:10]];
    [ordinate setMinBound:[NSNumber numberWithInt:0]];
    [ordinate setMaxBound:[NSNumber numberWithInt:100]];
    
    [cs prepare];
    
    UICoordinateSystem2D *uics = [[UICoordinateSystem2D alloc] initWithFrame:frame coordinateSystem:cs];
    uics.margin = 50.f;
    uics.wantsBackgroundPattern = YES;
    uics.wantsAxesName = YES;
    uics.backgroundPatternLineColor = [UIColor whiteColor];
    
    uics.abscissAxis.titleUnit = [NSNumber numberWithInt:1];
    uics.abscissAxis.lineColor = [UIColor whiteColor];
    uics.abscissAxis.titles = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    uics.abscissAxis.lineWidth = [NSNumber numberWithInt:2];
    uics.abscissAxis.unitSeparatorLineLength = [NSNumber numberWithInt:8];
    uics.abscissAxis.titleInterval = [NSNumber numberWithInt:1];
    
    uics.ordinateAxis.titleUnit = [NSNumber numberWithInt:1];
    uics.ordinateAxis.lineColor = [UIColor whiteColor];
    uics.ordinateAxis.titles = [NSArray arrayWithObjects:@"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90", @"100", nil];
    uics.ordinateAxis.lineWidth = [NSNumber numberWithInt:2];
    uics.ordinateAxis.unitSeparatorLineLength = [NSNumber numberWithInt:8];
    uics.ordinateAxis.titleInterval = [NSNumber numberWithInt:1];
    
    [uics draw];
    
    Curve *curve = [[Curve alloc] init];
    
    curve.values = [NSOrderedDictionary dictionaryWithObjects:
                    [NSArray arrayWithObjects:[NSNumber numberWithInt:12], [NSNumber numberWithInt:27], [NSNull null], [NSNull null], [NSNumber numberWithInt:50], [NSNumber numberWithInt:60], [NSNumber numberWithInt:73], [NSNumber numberWithInt:88], [NSNumber numberWithInt:19], [NSNumber numberWithInt:87], [NSNull null], [NSNumber numberWithInt:63], nil]
                                                      forKeys:
                    [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil]];
    
    
    UICurve *uicurve = [[UICurve alloc] initWithFrame:CGRectZero curve:curve];
    uicurve.lineColor = [UIColor whiteColor];
    uicurve.drawPoints = YES;
    uicurve.lineWidth = [NSNumber numberWithFloat:0.3];
    
    [uics drawCurve:uicurve];
    
    return uics;
}

@end
