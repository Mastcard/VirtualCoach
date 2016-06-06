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

@property (nonatomic) int day;
@property (nonatomic) int month;
@property (nonatomic) int year;

-(instancetype)initWithId:(int)videoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andMovements:(NSMutableArray<MovementDO*>*)movements andDay:(int)day andMonth:(int)month andYear:(int)year;

@end

#endif /* VideoDO_h */
