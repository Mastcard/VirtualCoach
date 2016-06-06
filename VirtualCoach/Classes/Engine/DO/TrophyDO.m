//
//  TrophyDO.m
//  VirtualCoach
//
//  Created by Adrien on 25/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrophyDO.h"

@implementation TrophyDO

-(instancetype)initWithId:(int)id andName:(NSString*)name andDescription:(NSString*)description {
    
    self = [super init];
    
    if (self) {
        _trophyId = id;
        _name = name;
        _trophyDescription = description;
    }
    
    return self;
}

@end
