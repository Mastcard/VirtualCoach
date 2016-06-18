//
//  InterfaceVideoDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef InterfaceVideoDO_h
#define InterfaceVideoDO_h

#import "InterfaceMovementDO.h"

@interface InterfaceVideoDO : NSObject

@property (nonatomic) int videoId;
@property (nonatomic) NSString* name;
@property (nonatomic) bool processed;
@property (nonatomic) bool removed;
@property (nonatomic) NSMutableArray<InterfaceMovementDO*>* movements;
@property (nonatomic) int day;
@property (nonatomic) int month;
@property (nonatomic) int year;

-(instancetype)initWithId:(int)referenceVideoId andName:(NSString*)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year;

@end

#endif /* InterfaceVideoDO_h */
