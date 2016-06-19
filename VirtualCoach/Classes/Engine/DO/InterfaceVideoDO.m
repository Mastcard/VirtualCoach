//
//  InterfaceVideoDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceVideoDO.h"

@implementation InterfaceVideoDO

-(instancetype)initWithId:(int)referenceVideoId andName:(NSString*)name andProcessed:(bool)processed andRemoved:(bool)removed andDay:(int)day andMonth:(int)month andYear:(int)year {
    
    self = [super init];
    
    if (self) {
        self.videoId = referenceVideoId;
        self.name = name;
        self.processed = processed;
        self.removed = removed;
        self.day = day;
        self.month = month;
        self.year = year;
    }
    
    return self;
}

@end