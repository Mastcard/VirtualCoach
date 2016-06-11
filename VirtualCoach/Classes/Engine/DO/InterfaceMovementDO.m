//
//  InterfaceMovementDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceMovementDO.h"

@implementation InterfaceMovementDO

-(instancetype)initWithMovementId:(int)movementId andType:(MovementEnum)type {
    self = [super init];
    
    if (self) {
        _movementId = movementId;
        _type = type;
    }
    
    return self;
}

@end