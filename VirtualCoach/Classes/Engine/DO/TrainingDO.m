//
//  TrainingDO.m
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrainingDO.h"

@implementation TrainingDO

-(instancetype)initWithId:(int)trainingId andDate:(NSDate*)date andName:(NSString*)name andPlace:(NSString*)place andVideos:(NSMutableArray<VideoDO*>*)videos {
    
    self = [super init];
    
    if (self) {
        _trainingId = trainingId;
        _date = date;
        _name = name;
        _place = place;
        _videos = videos;
    }
    
    return self;
}

@end