//
//  CoordinateSystem2D.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoordinateSystem.h"
#import "Axis.h"

@interface CoordinateSystem2D : CoordinateSystem

@property (nonatomic) BOOL orthonormal;

- (instancetype)initWithAxis:(Axis *)firstAxis secondAxis:(Axis *)secondAxis;

@end

