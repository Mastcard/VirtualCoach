//
//  Histogram.m
//  VirtualCoach
//
//  Created by Bi ZORO on 02/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "Histogram.h"

@implementation Histogram

- (instancetype)init{
    self = [super init];
    if (self){
        _data=[[NSMutableArray alloc]initWithCapacity:360];
        for (NSInteger i=0; i<360; i++) {
            [_data insertObject:@0 atIndex:i];
        }
    }
    return  self;
}

- (void)generateHistogramFromSpeedVector:(speedVector *)speed betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    double u = 0, v = 0;
    double angle = 0;
    double norm = 0;
    for (NSInteger y=interval.start.y; y<interval.end.y; y++) {
        for (NSInteger x=interval.start.x; x<interval.end.x; x++){
            u= speed[PXL_IDX(width, x, y)].u;
            v= speed[PXL_IDX(width, x, y)].v;
            norm = sqrt(u*u + v*v);
            if (norm > 0.00){
                angle = atan2(-v, u) * 180 / M_PI;
                if (angle < 0) {
                    angle += 360;
                }
                _data[(unsigned int) angle] = @([[_data objectAtIndex:(unsigned int) angle] intValue] + 1);
            }
        }
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"angle"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _data = [aDecoder decodeObjectForKey:@"angle"];
    }
    
    return self;
}

- (void)writeHistogramAtPath:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadHistogramAtPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


@end
