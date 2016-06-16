//
//  CoordinateSystem.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

@interface CoordinateSystem : NSObject <Element>

@property (nonatomic) NSUInteger dimensionCount;

@property (nonatomic) NSMutableDictionary *axes;

- (instancetype)initWithDimensionCount:(NSUInteger)dimensionCount;

- (void)prepare;

@end

