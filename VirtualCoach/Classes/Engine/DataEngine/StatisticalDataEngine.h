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
/*!
 * Inserts a statistical for a given player id.
 *
 * WARNING : if a statistical has already been inserted for the given day, month and year trio, then you should use UPDATE methods.
 *
 */
-(void)insertStatistical:(StatisticalDO*)statisticalDO forPlayerId:(int)playerId;

// SELECT
-(NSMutableArray<StatisticalDO*>*)searchAllStatisticals;
-(NSMutableArray<StatisticalDO*>*)searchByDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year;
-(NSMutableArray<StatisticalDO*>*)searchByMonth:(NSString*)month andYear:(NSString*)year;
-(NSMutableArray<StatisticalDO*>*)searchByYear:(NSString*)year;
-(NSMutableArray<StatisticalDO*>*)searchByPlayerId:(NSString*)playerId;

// UPDATE
-(void)updateServiceGlobalSuccessRate:(NSString*)serviceGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year;
-(void)updateForehandGlobalSuccessRate:(NSString*)forehandGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year;
-(void)updateBackhandGlobalSuccessRate:(NSString*)backhandGlobalSuccessRate forDay:(NSString*)day andMonth:(NSString*)month andYear:(NSString*)year;

// DELETE
-(void)deleteStatisticalById:(NSString*)statisticalId;

@end
