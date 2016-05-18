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
/*
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
    float percentSeuil =0;

    NSNumber * result;
    
    if(leftHandedRef != leftHandedPlayer){
        percentError = 100;
        resultFloat = fabsf(100 - percentError);
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
                    
                }
            }
        }
    }
    
    result = [NSNumber numberWithFloat:resultFloat];
    return result;
    
}
*/
/*
+ (NSNumber *) compare:(VCHistogram *)hRef histo:(VCHistogram *)hMvt seuil:(int)seuil{
    
    float resultFloat = 0;
    float percentError = 0;
    NSNumber * result;
    float nbTotalOccAngleMvt=0;
    float nbTotalOccAngleRef=0;
    float echcurentRefNbAngle=0;
    float curentRefNbAngle=0;
    float curentMvtNbAngle=0;
    float dif = 0;
    long error = 0;
    float percentSeuil =0;
    
    for (int i=0; i<(hRef.size); i++) {
        nbTotalOccAngleMvt = nbTotalOccAngleMvt + hMvt.content[i];
        nbTotalOccAngleRef = nbTotalOccAngleRef + hRef.content[i];
    }
    if (nbTotalOccAngleMvt == 0) {
        result =0;
        return result;
    }
    else{
        
        for(int i=0; i<(hRef.size); i++){
            
            curentRefNbAngle = hRef.content[i];
            curentMvtNbAngle = hMvt.content[i];
            echcurentRefNbAngle = (nbTotalOccAngleMvt*curentRefNbAngle)/nbTotalOccAngleRef;
            dif = fabsf(curentMvtNbAngle-echcurentRefNbAngle);
            percentSeuil = (echcurentRefNbAngle * seuil)/100;
            
            if (dif > percentSeuil) {
                error += dif;
            }
            else{
                printf("%lf\t and %lf\n", dif, percentSeuil);
            }
            
        }
        percentError = (error*100)/nbTotalOccAngleMvt;
        resultFloat = fabsf(100 - percentError);
        result = [NSNumber numberWithFloat:resultFloat];
        return result;
        
    }
    
}
*/
@end
