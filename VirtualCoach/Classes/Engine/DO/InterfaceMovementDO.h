//
//  InterfaceMovementDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef InterfaceMovementDO_h
#define InterfaceMovementDO_h

#import "MovementEnum.h"

@interface InterfaceMovementDO : NSObject

@property (nonatomic) int movementId;
@property (nonatomic) MovementEnum type;

-(instancetype)initWithMovementId:(int)movementId andType:(MovementEnum)type;

@end

#endif /* InterfaceMovementDO_h */
