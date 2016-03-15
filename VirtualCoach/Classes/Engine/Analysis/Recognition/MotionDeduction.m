//
//  MotionDeduction.m
//  VirtualCoach
//
//  Created by Bi ZORO on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MotionDeduction.h"

@implementation MotionDeduction

+ (NSString *)recognizeTennisMotionWithHistogram:(Histogram *)anglesHistogram andLeftHanded:(Boolean)leftHanded{
    
    NSString * result;
    
    unsigned int max = 0, angle = 400;
    for (NSInteger i=0; i<anglesHistogram.data.count; i++) {
        if([[anglesHistogram.data objectAtIndex:i] intValue] > max){
            max = [[anglesHistogram.data objectAtIndex:i] intValue];
            angle = (unsigned int) i;
        }
    }
    
    if(angle == 270){
        return result = @"serve";
    }
    
    if (leftHanded==false) {
        if (angle == 0) {
            return result = @"forehand";
        }
        if(angle == 180){
            return result = @"backhand";
        }
    }
    
    if (leftHanded==true) {
        if (angle == 0) {
            return result = @"backhand";
        }
        if(angle == 180){
            return result = @"forehand";
        }
    }
    
    // else angle != 0 || 180 || 270
    NSString *angleMax = [ NSString stringWithFormat:@"%d", angle] ;
    NSString *nbOccuMax = [ NSString stringWithFormat:@"%d", max] ;
    NSString *message = @"Motion not recognized";
    return result = [NSString stringWithFormat:@"%@ %@°:%@",message, angleMax, nbOccuMax];
    
    
}

@end
