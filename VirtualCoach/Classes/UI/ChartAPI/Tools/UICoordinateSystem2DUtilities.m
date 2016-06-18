//
//  UICoordinateSystem2DUtilities.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICoordinateSystem2DUtilities.h"

@implementation UICoordinateSystem2DUtilities

+ (NSString *)titleForTouchLocation:(CGPoint)locationPoint inCoordinateSystem:(UICoordinateSystem2D *)coordinateSystem
{
    if ((locationPoint.x < coordinateSystem.margin) || (locationPoint.x >  (coordinateSystem.frame.size.width + coordinateSystem.margin))) // if touch is outside X axis real coordinates
        return nil;
    
    Axis *xAxis = ((Axis *)[coordinateSystem.coordinateSystem.axes objectForKey:@"absciss"]);
    
    CGFloat unitIntervalX = xAxis.maxBound.floatValue / xAxis.unit.floatValue;
    CGFloat unitWidth = (coordinateSystem.frame.size.width - (coordinateSystem.margin * 2)) / unitIntervalX;
    CGFloat currentXForSeparator = coordinateSystem.margin + unitWidth;
    
    CGFloat winner = CGFLOAT_MAX;
    NSString *winningTitle = nil;
    
    for (NSUInteger i = 0; i < coordinateSystem.abscissAxis.titles.count; i++)
    {
        int distance = abs((int)(locationPoint.x - currentXForSeparator));
        
        if (distance < winner)
        {
            winner = distance;
            winningTitle = [coordinateSystem.abscissAxis.titles objectAtIndex:i];
        }
            
        currentXForSeparator += unitWidth;
    }
    
    return winningTitle;
}

@end
