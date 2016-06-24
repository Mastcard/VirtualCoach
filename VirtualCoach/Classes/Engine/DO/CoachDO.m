//
//  Coach.m
//  VirtualCoach
//
//  Created by Adrien on 23/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoachDO.h"

@implementation CoachDO

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _players = [[NSMutableArray<PlayerDO*>  alloc] init];
        _referenceVideos = [[NSMutableArray<ReferenceVideoDO*> alloc] init];
    }
    
    return self;
}

-(instancetype)initWithCoachId:(int)coachId andName:(NSString*)name andFirstName:(NSString*)firstName andLogin:(NSString*)login andPassword:(NSString*)password andLeftHanded:(bool)leftHanded andPlayers:(NSMutableArray<PlayerDO*>*)players andReferenceVideos:(NSMutableArray<ReferenceVideoDO*>*)referenceVideos {
    
    self = [super init];
    
    if (self) {
        _coachId = coachId;
        _name = name;
        _firstName = firstName;
        _login = login;
        _password = password;
        _leftHanded = leftHanded;
        _players = players;
        _referenceVideos = referenceVideos;
    }
    
    return self;
}

@end