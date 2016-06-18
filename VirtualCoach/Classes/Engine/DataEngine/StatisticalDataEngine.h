//
//  StatisticalDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticalDAO.h"
#import "StatisticalDO.h"

@interface StatisticalDataEngine : NSObject

@property (nonatomic) StatisticalDAO* statisticalDAO;

// INSERT
-(void)insertStatistical:(StatisticalDO*)statisticalDO;

// SELECT
-(NSMutableArray<StatisticalDO*>*)searchAllStatistics;
-(NSArray*)searchByDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year;

@end
