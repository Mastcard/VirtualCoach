//
//  Coach.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef Coach_h
#define Coach_h

#import <Foundation/Foundation.h>
#import "PlayerDO.h"
#import "ReferenceVideoDO.h"

@interface CoachDO : NSObject

@property (nonatomic) int coachId;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* firstName;
@property (nonatomic) NSString* login;
@property (nonatomic) NSString* password;
@property (nonatomic) bool leftHanded;
@property (nonatomic) NSMutableArray<PlayerDO*>* players;
@property (nonatomic) NSMutableArray<ReferenceVideoDO*>* referenceVideos;

-(instancetype)initWithCoachId:(int)coachId andName:(NSString*)name andFirstName:(NSString*)firstName andLogin:(NSString*)login andPassword:(NSString*)password andLeftHanded:(bool)leftHanded andPlayers:(NSMutableArray<PlayerDO*>*)players andReferenceVideos:(NSMutableArray<ReferenceVideoDO*>*)referenceVideos;

@end

#endif /* Coach_h */
