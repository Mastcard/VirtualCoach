//
//  StatisticDO.h
//  VirtualCoach
//
//  Created by Adrien on 25/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef StatisticalDO_h
#define StatisticalDO_h

@interface StatisticalDO : NSObject

@property (nonatomic) int statisticalId;
@property (nonatomic) int forehandCount;
@property (nonatomic) int backhandCount;
@property (nonatomic) int serviceCount;
@property (nonatomic) int winningRun;
@property (nonatomic) int loosingRun;
@property (nonatomic) float forehandGlobalSuccessRate;
@property (nonatomic) float backhandGlobalSuccessRate;
@property (nonatomic) float serviceGlobalSuccessRate;
@property (nonatomic) int day;
@property (nonatomic) int month;
@property (nonatomic) int year;

-(instancetype)initWithId:(int)statisticalId andForehandCount:(int)forehandCount andBackhandCount:(int)backhandCount andServiceCount:(int)serviceCount andWinningRun:(int)winningRun andLoosingRun:(int)loosingRun andForehandGlobalSuccessRate:(float)forehandGlobalSuccessRate andBackhandGlobalSuccessRate:(float)backhandGlobalSuccessRate andServiceGlobalSuccessRate:(float)serviceGlobalSuccessRate andDay:(int)day andMonth:(int)month andYear:(int)year;

@end

#endif /* StatisticDO_h */
