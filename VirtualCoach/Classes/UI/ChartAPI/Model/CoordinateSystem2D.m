//
//  CoordinateSystem2D.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoordinateSystem2D.h"
#import "Axis.h"
#import "DateUtilities.h"

@implementation CoordinateSystem2D

- (instancetype)init
{
    return [self initWithAxis:[[Axis alloc] initWithIdentifier:@"absciss"] secondAxis:[[Axis alloc] initWithIdentifier:@"ordinate"]];
}

- (instancetype)initWithAxis:(Axis *)firstAxis secondAxis:(Axis *)secondAxis
{
    self = [super initWithDimensionCount:2];
    
    if (self)
    {
        _orthonormal = YES;
        
        [self.axes setObject:firstAxis forKey:firstAxis.identifier];
        [self.axes setObject:secondAxis forKey:secondAxis.identifier];
    }
    
    return self;
}

@end
