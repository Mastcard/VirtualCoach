//
//  MotionDeduction.m
//  VirtualCoach
//
//  Created by Bi ZORO on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MotionDeduction.h"

@interface MotionDeduction()

+ (NSNumber *) compareHistogramReference:(Histogram *)hRef isLeftHanded:(Boolean)leftHandedRef withHistogramofPLayer:(Histogram *)hMvt isLeftHanded:(Boolean)leftHandedPlayer andThreshold:(int)threshold;

@end

@implementation MotionDeduction

+ (NSString *)recognizeTennisMotionWithHistogram:(Histogram *)anglesHistogram andLeftHanded:(Boolean)leftHanded{
    
    NSString * result;
    
    int max = 0, angle = 400;
    for (NSInteger i=0; i<anglesHistogram.data.count; i++) {
        if([[anglesHistogram.data objectAtIndex:i] intValue] > max){
            max = [[anglesHistogram.data objectAtIndex:i] intValue];
            angle = (int) i;
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
    }else if (leftHanded==true) {
        if (angle == 0) {
            return result = @"backhand";
        }
        if(angle == 180){
            return result = @"forehand";
        }
    }
    NSString *angleMax = [ NSString stringWithFormat:@"%d", angle] ;
    NSString *nbOccuMax = [ NSString stringWithFormat:@"%d", max] ;
    NSString *message = @"Motion not recognized";
    return result = [NSString stringWithFormat:@"%@ %@°:%@",message, angleMax, nbOccuMax];
    
}

+ (NSString *)recognizeTennisMotionWithFilterHistogram:(Histogram *)anglesHistogram andLeftHanded:(Boolean)leftHanded{
    
    NSString * result;
    
    if([[anglesHistogram.data objectAtIndex:270] intValue] > [[anglesHistogram.data objectAtIndex:0] intValue] && [[anglesHistogram.data objectAtIndex:270] intValue] > [[anglesHistogram.data objectAtIndex:180] intValue]){
        return result = @"serve";
    }
    if (leftHanded==false){
        if([[anglesHistogram.data objectAtIndex:0] intValue] > [[anglesHistogram.data objectAtIndex:180] intValue] && [[anglesHistogram.data objectAtIndex:0] intValue] > [[anglesHistogram.data objectAtIndex:270] intValue]){
            return result = @"forehand";
        } else if([[anglesHistogram.data objectAtIndex:180] intValue] > [[anglesHistogram.data objectAtIndex:0] intValue] && [[anglesHistogram.data objectAtIndex:180] intValue] > [[anglesHistogram.data objectAtIndex:270] intValue]){
            return result = @"backhand";
        }
    } else if (leftHanded==true) {
        if([[anglesHistogram.data objectAtIndex:0] intValue] > [[anglesHistogram.data objectAtIndex:180] intValue] && [[anglesHistogram.data objectAtIndex:0] intValue] > [[anglesHistogram.data objectAtIndex:270] intValue]){
            return result = @"backhand";
        } else if([[anglesHistogram.data objectAtIndex:180] intValue] > [[anglesHistogram.data objectAtIndex:0] intValue] && [[anglesHistogram.data objectAtIndex:180] intValue] > [[anglesHistogram.data objectAtIndex:270] intValue]){
            return result = @"forehand";
        }
    }
    return result;
}

/*
+ (NSNumber *)bhattacharyyaBetweenFirstAngleHistogram:(Histogram *)histo1 andSecondHistogram:(Histogram *)histo2{

    NSNumber * result;
    float countTotalOccAngleHisto1=0;
    float countTotalOccAngleHisto2=0;
    float occAngleIHisto1 = 0;
    float occAngleIHisto2 = 0;
    float da = 0., bca = 0.;
    if ([histo1 data].count > 0 && [histo2 data].count > 0) {
        for (int i=0; i<[histo2 data].count; i++) {
            countTotalOccAngleHisto1 += [histo1.data[i] floatValue];
            countTotalOccAngleHisto2 += [histo2.data[i] floatValue];
        }
        if(countTotalOccAngleHisto2 == 0. || countTotalOccAngleHisto1 == 0.){
            da = 0;
        } else {
            for (int j=0; j<[histo2 data].count; j++){
                occAngleIHisto1 = [histo1.data[j] floatValue]/ countTotalOccAngleHisto1;
                occAngleIHisto2 = [histo2.data[j] floatValue]/ countTotalOccAngleHisto2;
                bca += sqrtf(occAngleIHisto1 * occAngleIHisto2);
            }
            da = (bca > 0) ? -log((double)bca) : 0;
            
        }
    }
    result = [[NSNumber alloc]initWithFloat:da];
    return result;
}
*/

+ (NSNumber *) compareHistogramReference:(Histogram *)hRef isLeftHanded:(Boolean)leftHandedRef withHistogramofPLayer:(Histogram *)hMvt isLeftHanded:(Boolean)leftHandedPlayer andThreshold:(int)threshold{
    
    float resultFloat = 0;
    float percentError = 0;
    float countTotalOccAngleMvt=0;
    float countTotalOccAngleRef=0;
    float echcurentRefCountAngle=0;
    float curentRefCountAngle=0;
    float curentMvtCountAngle=0;
    float dif = 0;
    long error = 0;
    float percentThreshold =0;

    NSNumber * result;
    
    if(leftHandedRef != leftHandedPlayer){
        
        if(leftHandedRef == true){
            
            Histogram * newHref = [[Histogram alloc] init];
            for (NSInteger i=0; i<[[newHref data] count]; i++) {
                int newAngle = (int) (180 - i);
                if(newAngle<0){
                    newAngle = newAngle +360;
                }
                [[newHref data] replaceObjectAtIndex:i withObject:[[hRef data] objectAtIndex:newAngle]];
            }
            
            if ([newHref data].count > 0 && [hMvt data].count > 0){
                for (int i=0; i<[hMvt data].count; i++) {
                    countTotalOccAngleMvt += [newHref.data[i] floatValue];
                    countTotalOccAngleRef += [hMvt.data[i] floatValue];
                }
                if (countTotalOccAngleRef > 0){
                    for (int j=0; j<[hMvt data].count; j++){
                        curentRefCountAngle = [newHref.data[j] floatValue];
                        curentMvtCountAngle = [hMvt.data[j] floatValue];
                        echcurentRefCountAngle =(countTotalOccAngleMvt*curentRefCountAngle)/countTotalOccAngleRef;
                        dif = fabsf(curentMvtCountAngle-echcurentRefCountAngle);
                        percentThreshold = (echcurentRefCountAngle * threshold)/100;
                        if (dif > percentThreshold) {
                            error += dif;
                        }
                    }
                    percentError = (error*100)/countTotalOccAngleMvt;
                    resultFloat = fabsf(100 - percentError);
                } else {
                    NSLog(@"Bug: histogram reference have no value");
                }
            }
            
        } else if(leftHandedPlayer == true){
            
            Histogram * newhMvt = [[Histogram alloc] init];
            for (NSInteger i=0; i<[[newhMvt data] count]; i++) {
                int newAngle = (int) (180 - i);
                if(newAngle<0){
                    newAngle = newAngle +360;
                }
                [[newhMvt data] replaceObjectAtIndex:i withObject:[[hMvt data] objectAtIndex:newAngle]];
            }
            
            if ([hRef data].count > 0 && [newhMvt data].count > 0){
                for (int i=0; i<[hMvt data].count; i++) {
                    countTotalOccAngleMvt += [hRef.data[i] floatValue];
                    countTotalOccAngleRef += [newhMvt.data[i] floatValue];
                }
                if (countTotalOccAngleRef > 0){
                    for (int j=0; j<[hMvt data].count; j++){
                        curentRefCountAngle = [hRef.data[j] floatValue];
                        curentMvtCountAngle = [newhMvt.data[j] floatValue];
                        echcurentRefCountAngle =(countTotalOccAngleMvt*curentRefCountAngle)/countTotalOccAngleRef;
                        dif = fabsf(curentMvtCountAngle-echcurentRefCountAngle);
                        percentThreshold = (echcurentRefCountAngle * threshold)/100;
                        if (dif > percentThreshold) {
                            error += dif;
                        }
                    }
                    percentError = (error*100)/countTotalOccAngleMvt;
                    resultFloat = fabsf(100 - percentError);
                } else {
                    NSLog(@"Bug: histogram reference have no value");
                }
            }
            
        }
        
    } else {
        if ([hRef data].count > 0 && [hMvt data].count > 0){
            for (int i=0; i<[hMvt data].count; i++) {
                countTotalOccAngleMvt += [hRef.data[i] floatValue];
                countTotalOccAngleRef += [hMvt.data[i] floatValue];
            }
            if (countTotalOccAngleRef > 0){
                for (int j=0; j<[hMvt data].count; j++){
                    curentRefCountAngle = [hRef.data[j] floatValue];
                    curentMvtCountAngle = [hMvt.data[j] floatValue];
                    echcurentRefCountAngle =(countTotalOccAngleMvt*curentRefCountAngle)/countTotalOccAngleRef;
                    dif = fabsf(curentMvtCountAngle-echcurentRefCountAngle);
                    percentThreshold = (echcurentRefCountAngle * threshold)/100;
                    if (dif > percentThreshold) {
                        error += dif;
                    }
                }
                percentError = (error*100)/countTotalOccAngleMvt;
                resultFloat = fabsf(100 - percentError);
            } else {
                NSLog(@"Bug: histogram reference have no value");
            }
        }
    }
    
    result = [NSNumber numberWithFloat:resultFloat];
    return result;
    
}

+(NSString *)compareHistogram:(Histogram *)mvt isPlayerLeftHanded:(Boolean)leftHandedPlayer pathHistogramRef:(NSString *)path isCoachLeftHanded:(Boolean)leftHandedCoatch withThreshold:(int)threshold{
    
    NSString * percentResultString = @"0";
    
    Histogram * histogramRef;
    histogramRef = [Histogram loadHistogramAtPath:path];
    
    NSNumber * percentResult = [MotionDeduction compareHistogramReference:histogramRef isLeftHanded:leftHandedCoatch withHistogramofPLayer:mvt isLeftHanded:leftHandedPlayer andThreshold:threshold];
    
    percentResultString = [percentResult stringValue];
    
    return percentResultString;
    
}

@end
