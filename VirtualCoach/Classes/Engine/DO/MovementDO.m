//
//  MovementDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovementDO.h"

@implementation MovementDO

-(instancetype)initWithId:(int)movementId andType:(MovementEnum)type andWinning:(bool)winning andLoosing:(bool)loosing andSuccessRate:(float)successRate {
    
    self = [super initWithMovementId:movementId andType:type];
    
    if (self) {
        _winning = winning;
        _loosing = loosing;
        _successRate = successRate;
    }
    
    return self;
}

@end