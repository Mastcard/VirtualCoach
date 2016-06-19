//
//  Axis.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

@interface Axis : NSObject <Element>

@property (nonatomic) NSString *identifier;

@property (nonatomic) NSNumber *unit;

@property (nonatomic) NSNumber *minBound;

@property (nonatomic) NSNumber *maxBound;

@property (nonatomic) NSMutableArray *values;

- (instancetype)initWithIdentifier:(NSString *)identifier unit:(NSNumber *)unit;
- (instancetype)initWithIdentifier:(NSString *)identifier;

- (void)prepare;

+ (instancetype)defaultAxis;
+ (instancetype)dailyAxis;
+ (instancetype)weeklyAxis;
+ (instancetype)monthlyAxisForCurrentMonth;
+ (instancetype)monthlyAxisForMonth:(NSInteger)month;
+ (instancetype)yearlyAxis;
+ (instancetype)progressAxis;
+ (instancetype)motionCountAxis;


@end
