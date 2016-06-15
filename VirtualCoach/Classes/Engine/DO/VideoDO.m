//
//  VideoDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoDO.h"

@implementation VideoDO

-(instancetype)initWithId:(int)videoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andMovements:(NSMutableArray<MovementDO*>*)movements andDay:(int)day andMonth:(int)month andYear:(int)year {
    
    self = [super initWithId:videoId andName:name andProcessed:processed andRemoved:removed];
    
    if (self) {
        self.movements = movements;
        _day = day;
        _month = month;
        _year = year;
    }
    
    return self;
}

@end
