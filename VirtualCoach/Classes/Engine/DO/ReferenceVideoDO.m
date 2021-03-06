//
//  ReferenceVideoDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReferenceVideoDO.h"

@implementation ReferenceVideoDO

-(instancetype)initWithId:(int)referenceVideoId andName:(NSString *)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year andReferenceMovements:(NSMutableArray<ReferenceMovementDO*>*)referenceMovements {
    
    self = [super initWithId:referenceVideoId andName:name andProcessed:processed andRemoved:removed andDay:day andMonth:month andYear:year];
    
    if (self) {
        self.movements = referenceMovements;
    }
    
    return self;
}

@end
