//
//  CoordinateSystem.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoordinateSystem.h"
#import "Axis.h"

@implementation CoordinateSystem

- (instancetype)initWithDimensionCount:(NSUInteger)dimensionCount
{
    self = [super init];
    
    if (self)
    {
        _dimensionCount = dimensionCount;
        _axes = [[NSMutableDictionary alloc] initWithCapacity:dimensionCount];
    }
    
    return self;
}

- (void)prepare
{
    for (NSObject *obj in [_axes allValues])
    {
        Axis *axis = (Axis *)obj;
        [axis prepare];
    }
}

- (NSString *)description
{
    NSMutableString *description = [[NSMutableString alloc] init];
    
    for (NSObject *obj in [_axes allValues])
    {
        Axis *axis = (Axis *)obj;
        [description appendString:[axis description]];
    }
    
    return description;
}


@end

