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

-(instancetype)initWithId:(int)videoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year andMovements:(NSMutableArray<MovementDO*>*)movements {
    
    self = [super initWithId:videoId andName:name andProcessed:processed andRemoved:removed andDay:day andMonth:month andYear:year];
    
    if (self) {
        self.movements = movements;
    }
    
    return self;
}

@end
