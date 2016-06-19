//
//  VideoDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef VideoDO_h
#define VideoDO_h

#import "InterfaceVideoDO.h"
#import "MovementDO.h"
#import "PlayerDO.h"

@interface VideoDO : InterfaceVideoDO

-(instancetype)initWithId:(int)videoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year andMovements:(NSMutableArray<MovementDO*>*)movements;

@end

#endif /* VideoDO_h */
