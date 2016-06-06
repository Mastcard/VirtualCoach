//
//  MovementDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef MovementDO_h
#define MovementDO_h

#import "InterfaceMovementDO.h"

@interface MovementDO : InterfaceMovementDO

@property (nonatomic) bool winning;
@property (nonatomic) bool loosing;
@property (nonatomic) float successRate;

-(instancetype)initWithId:(int)movementId andType:(MovementEnum)type andWinning:(bool)winning andLoosing:(bool)loosing andSuccessRate:(float)successRate;

@end

#endif /* MovementDO_h */
