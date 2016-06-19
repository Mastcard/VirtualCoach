//
//  Axis.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "Axis.h"
#import "DateUtilities.h"

@implementation Axis

- (instancetype)initWithIdentifier:(NSString *)identifier unit:(NSNumber *)unit
{
    self = [super init];
    
    if (self)
    {
        _identifier = identifier;
        _unit = unit;
        _values = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier unit:[NSNumber numberWithInt:1]];
}

- (void)prepare
{
    if (_values.count > 0)
        [_values removeAllObjects];
    
    for (float i = [_minBound floatValue]; i <= [_maxBound floatValue]; i += [_unit floatValue])
        [_values addObject:[NSNumber numberWithFloat:i]];
}

+ (instancetype)defaultAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"default"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:0]];
    [axis setMaxBound:[NSNumber numberWithInt:20]];
    
    return axis;
}

+ (instancetype)dailyAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"default"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:1]];
    [axis setMaxBound:[NSNumber numberWithInt:24]];
    
    return axis;
}

+ (instancetype)weeklyAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"default"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:1]];
    [axis setMaxBound:[NSNumber numberWithInt:7]];
    
    return axis;
}

+ (instancetype)monthlyAxisForCurrentMonth
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"absciss"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:1]];
    [axis setMaxBound:[NSNumber numberWithInt:(int)[DateUtilities dayCountForCurrentMonth]]];
    
    return axis;
}

+ (instancetype)monthlyAxisForMonth:(NSInteger)month
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"absciss"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:1]];
    [axis setMaxBound:[NSNumber numberWithInt:(int)[DateUtilities dayCountForMonth:month]]];
    
    return axis;
}

+ (instancetype)yearlyAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"default"];
    [axis setUnit:[NSNumber numberWithInt:1]];
    [axis setMinBound:[NSNumber numberWithInt:1]];
    [axis setMaxBound:[NSNumber numberWithInt:12]];
    
    return axis;
}

+ (instancetype)progressAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"ordinate"];
    [axis setUnit:[NSNumber numberWithInt:10]];
    [axis setMinBound:[NSNumber numberWithInt:0]];
    [axis setMaxBound:[NSNumber numberWithInt:100]];
    
    return axis;
}

+ (instancetype)motionCountAxis
{
    Axis *axis = [[Axis alloc] initWithIdentifier:@"ordinate"];
    [axis setUnit:[NSNumber numberWithInt:100]];
    [axis setMinBound:[NSNumber numberWithInt:0]];
    [axis setMaxBound:[NSNumber numberWithInt:1000]];
    
    return axis;
}

- (NSString *)description
{
    NSMutableString *description = [[NSMutableString alloc] init];
    
    [description appendString:[NSString stringWithFormat:@"Identifier : %@\n", _identifier]];
    [description appendString:[NSString stringWithFormat:@"Unit : %f\n", _unit.floatValue]];
    [description appendString:[NSString stringWithFormat:@"Min : %f\n", _minBound.floatValue]];
    [description appendString:[NSString stringWithFormat:@"Max : %f\n", _maxBound.floatValue]];
    
    for (NSUInteger i = 0; i < [_values count]; i++)
        [description appendString:[NSString stringWithFormat:@"%f\n", [[_values objectAtIndex:i] floatValue]]];
    
    return description;
}


@end
