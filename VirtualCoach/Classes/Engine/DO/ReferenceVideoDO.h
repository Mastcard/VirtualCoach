//
//  ReferenceVideoDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef ReferenceVideoDO_h
#define ReferenceVideoDO_h

#import "InterfaceVideoDO.h"
#import "ReferenceMovementDO.h"

@interface ReferenceVideoDO : InterfaceVideoDO

-(instancetype)initWithId:(int)referenceVideoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year andReferenceMovements:(NSMutableArray<ReferenceMovementDO*>*)referenceMovements;

@end

#endif /* ReferenceVideoDO_h */
