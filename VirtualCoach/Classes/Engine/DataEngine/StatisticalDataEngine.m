//
//  StatisticalDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "StatisticalDataEngine.h"

@implementation StatisticalDataEngine

/*
 * Instantiates a new StatisticalDataEngine.
 */
-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        _statisticalDAO = [[StatisticalDAO alloc] init];
    }
    
    return self;
}

//
// #### INSERT ####
//
-(void)insertStatistical:(StatisticalDO*)statisticalDO forPlayerId:(int)playerId {
    
    if (statisticalDO) {
        
        NSString* forehandCount = [NSString stringWithFormat:@"%d", statisticalDO.forehandCount];
        NSString* backhandCount = [NSString stringWithFormat:@"%d", statisticalDO.backhandCount];
        NSString* serviceCount = [NSString stringWithFormat:@"%d", statisticalDO.serviceCount];
        NSString* winningRun = [NSString stringWithFormat:@"%d", statisticalDO.winningRun];
        NSString* loosingRun = [NSString stringWithFormat:@"%d", statisticalDO.loosingRun];
        NSString* forehandGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.forehandGlobalSuccessRate];
        NSString* backhandGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.backhandGlobalSuccessRate];
        NSString* serviceGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.serviceGlobalSuccessRate];
        NSString* day = [NSString stringWithFormat:@"%d", statisticalDO.day];
        NSString* month = [NSString stringWithFormat:@"%d", statisticalDO.month];
        NSString* year = [NSString stringWithFormat:@"%d", statisticalDO.year];
        NSString* playerIdString = [NSString stringWithFormat:@"%d", playerId];
        
        [_statisticalDAO insertIntoStatistical:forehandCount
                                          backhanh:backhandCount
                                           service:serviceCount
                                        winningRun:winningRun
                                         losingRun:loosingRun
                         globalSuccessRateForehand:forehandGlobalSuccessRate
                         globalSuccessRateBackhand:backhandGlobalSuccessRate
                          globalSuccessRateService:serviceGlobalSuccessRate
                                               day:day
                                             month:month
                                              year:year
                                          idPlayer:playerIdString];
        
    } else {
        NSLog(@"Error : the statisticalDO is nil");
    }
}

//
// #### SELECT ####
//
-(NSMutableArray<StatisticalDO*>*)searchAllStatisticals {
    return nil;
}

-(NSMutableArray<StatisticalDO*>*)searchByDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year {
    return nil;
}

-(NSMutableArray<StatisticalDO*>*)searchByMonth:(NSString*)month andYear:(NSString*)year {
    return nil;
}

-(NSMutableArray<StatisticalDO*>*)searchByYear:(NSString*)year {
    return nil;
}

-(NSMutableArray<StatisticalDO*>*)searchByPlayerId:(NSString*)playerId {
    return nil;
}

//
// #### UPDATE ####
//
-(void)updateServiceGlobalSuccessRate:(NSString*)serviceGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year {
    
}

-(void)updateForehandGlobalSuccessRate:(NSString*)forehandGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year {
    
}

-(void)updateBackhandGlobalSuccessRate:(NSString*)backhandGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year {
    
}

//
// #### DELETE ####
//
-(void)deleteStatisticalById:(NSString*)statisticalId {
    
}


@end



