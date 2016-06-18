//
//  StatisticDO.m
//  VirtualCoach
//
//  Created by Adrien on 25/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticalDO.h"

@implementation StatisticalDO

-(instancetype)initWithId:(int)statisticalId andForehandCount:(int)forehandCount andBackhandCount:(int)backhandCount andServiceCount:(int)serviceCount andWinningRun:(int)winningRun andLoosingRun:(int)loosingRun andForehandGlobalSuccessRate:(float)forehandGlobalSuccessRate andBackhandGlobalSuccessRate:(float)backhandGlobalSuccessRate andServiceGlobalSuccessRate:(float)serviceGlobalSuccessRate andDay:(int)day andMonth:(int)month andYear:(int)year {
    
    self = [super init];
    
    if (self) {
        _statisticalId = statisticalId;
        _forehandCount = forehandCount;
        _backhandCount = backhandCount;
        _serviceCount = serviceCount;
        _winningRun = winningRun;
        _loosingRun = loosingRun;
        _forehandGlobalSuccessRate = forehandGlobalSuccessRate;
        _backhandGlobalSuccessRate = backhandGlobalSuccessRate;
        _serviceGlobalSuccessRate = serviceGlobalSuccessRate;
        _day = day;
        _month = month;
        _year = year;
    }
    
    return self;
}

@end