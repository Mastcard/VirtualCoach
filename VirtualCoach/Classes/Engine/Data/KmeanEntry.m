//
//  KmeanEntry.m
//  VirtualCoach
//
//  Created by Bi ZORO on 03/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "KmeanEntry.h"

@implementation KmeanEntry

- (instancetype)init{
    self = [super init];
    if (self){
        _time =0;
        _maxAngle =0;
        _meanAcceleration =0;
    }
    return  self;
}
/*
- (void)generateDataEntryForKmeanFromFirstSpeedVectorsTab:(speedVector *)speed1 andSecondSpeedVectorsTab:(speedVector *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    NSMutableArray * tmpHistogram = [[NSMutableArray alloc] initWithCapacity:360];
    for (NSInteger i=0; i<360; i++) {
        [tmpHistogram insertObject:@0 atIndex:i];
    }
    
    double cumulAcceleration =0;
    unsigned int nbAcceleration =0;
    
    unsigned int minHit =0;
    
    double u1 = 0, u2 = 0, v1 = 0, v2= 0;
    double angle = 0;
    double norm1 = 0, norm2 =0;
    for (NSInteger y=interval.start.y; y<interval.end.y; y++) {
        for (NSInteger x=interval.start.x; x<interval.end.x; x++){
            u2= speed2[PXL_IDX(width, x, y)].u;
            v2= speed2[PXL_IDX(width, x, y)].v;
            norm2 = sqrt(u2*u2 + v2*v2);
            
            u1= speed1[PXL_IDX(width, x, y)].u;
            v1= speed1[PXL_IDX(width, x, y)].v;
            norm1 = sqrt(u1*u1 + v1*v1);
            if (norm2 > 0.00){
                angle = atan2(-v2, u2) * 180 / M_PI;
                if (angle < 0) {
                    angle += 360;
                }
                tmpHistogram[(unsigned int) angle] = @([[tmpHistogram objectAtIndex:(unsigned int) angle] intValue] + 1);
            }
            cumulAcceleration += norm2 - norm1;
            nbAcceleration ++;
        }
    }
    _meanAcceleration = cumulAcceleration / nbAcceleration;
    
    for (NSInteger i=0; i<360; i++) {
        if ([[tmpHistogram objectAtIndex:i] intValue] > minHit) {
            minHit = [[tmpHistogram objectAtIndex:i] intValue];
            _maxAngle = (unsigned int)i;
        }
    }
    [tmpHistogram removeAllObjects];
}
*/

- (void)generateDataEntryForKmeanFromFirstSpeedVectorsTab:(speedVector *)speed1 andSecondSpeedVectorsTab:(speedVector *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    NSMutableArray * tmpHistogram = [[NSMutableArray alloc] initWithCapacity:360];
    for (NSInteger i=0; i<360; i++) {
        [tmpHistogram insertObject:@0 atIndex:i];
    }
    
    unsigned int minHit =0;
    double u1 = 0, u2 = 0, v1 = 0, v2= 0;
    double angle = 0;
    double norm1 = 0, norm2 =0;
    double meanSpeed1=0, meanSpeed2=0;
    unsigned int countSpeed1=0, countSpeed2=0;
    for (NSInteger y=interval.start.y; y<interval.end.y; y++) {
        for (NSInteger x=interval.start.x; x<interval.end.x; x++){
            u2= speed2[PXL_IDX(width, x, y)].u;
            v2= speed2[PXL_IDX(width, x, y)].v;
            norm2 += sqrt(u2*u2 + v2*v2);
            countSpeed1 ++;
            u1= speed1[PXL_IDX(width, x, y)].u;
            v1= speed1[PXL_IDX(width, x, y)].v;
            norm1 += sqrt(u1*u1 + v1*v1);
            countSpeed2++;
            if (norm2 > 0.00){
                angle = atan2(-v2, u2) * 180 / M_PI;
                if (angle < 0) {
                    angle += 360;
                }
                tmpHistogram[(unsigned int) angle] = @([[tmpHistogram objectAtIndex:(unsigned int) angle] intValue] + 1);
            }
        }
    }
    meanSpeed1 = norm1/countSpeed1;
    meanSpeed2 = norm2/countSpeed2;
    _meanAcceleration = norm2 - norm1;
    
    for (NSInteger i=0; i<360; i++) {
        if ([[tmpHistogram objectAtIndex:i] intValue] > minHit) {
            minHit = [[tmpHistogram objectAtIndex:i] intValue];
            _maxAngle = (unsigned int)i;
        }
    }
    [tmpHistogram removeAllObjects];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.time forKey:@"time"];
    [aCoder encodeInt:self.maxAngle forKey:@"angle"];
    [aCoder encodeDouble:self.meanAcceleration forKey:@"acceleration"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _time =[aDecoder decodeIntForKey:@"time"];
        _maxAngle =[aDecoder decodeIntForKey:@"angle"];
        _meanAcceleration =[aDecoder decodeDoubleForKey:@"acceleration"];
    }
    
    return self;
}


@end
