//
//  PlayerDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "PlayerDO.h"

@implementation PlayerDO

-(instancetype)initWithId:(int)playerId andName:(NSString*)name andFirstName:(NSString*)firstName andLeftHanded:(bool)leftHanded andStatistics:(NSMutableArray<StatisticalDO*>*)statistics andTrophies:(NSMutableArray<TrophyDO*>*)trophies {
    
    self = [super init];
    
    if (self) {
        _playerId = playerId;
        _name = name;
        _firstName = firstName;
        _leftHanded = leftHanded;
        _statistics = statistics;
        _trophies = trophies;
    }
    
    return self;
}

-(instancetype)initWithId:(int)playerId andName:(NSString*)name andFirstName:(NSString*)firstName andLeftHanded:(bool)leftHanded andStatistics:(NSMutableArray<StatisticalDO*>*)statistics andTrophies:(NSMutableArray<TrophyDO*>*)trophies level:(NSString *)level {
    
    self = [super init];
    
    if (self) {
        _playerId = playerId;
        _name = name;
        _firstName = firstName;
        _leftHanded = leftHanded;
        _statistics = statistics;
        _trophies = trophies;
        _level = level;
    }
    
    return self;
}

@end

