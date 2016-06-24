//
//  StatisticalDataEngineTools.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "StatisticalDataEngineTools.h"

@implementation StatisticalDataEngineTools

+ (NSMutableArray *)selectForehandCountsFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *forehandCounts = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.forehandCount > -1 ? [NSNumber numberWithInt:statisticalDO.forehandCount] : [NSNull null];
        [forehandCounts addObject:obj];
    }
    
    return forehandCounts;
}

+ (NSMutableArray *)selectBackhandCountsFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *backhandCounts = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.backhandCount > -1 ? [NSNumber numberWithInt:statisticalDO.backhandCount] : [NSNull null];
        [backhandCounts addObject:obj];
    }
    
    return backhandCounts;
}

+ (NSMutableArray *)selectServiceCountsFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *serviceCounts = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.serviceCount > -1 ? [NSNumber numberWithInt:statisticalDO.serviceCount] : [NSNull null];
        [serviceCounts addObject:obj];
    }
    
    return serviceCounts;
}

+ (NSMutableArray *)selectForehandProgressFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *forehandProgress = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.forehandGlobalSuccessRate > -1 ? [NSNumber numberWithFloat:statisticalDO.forehandGlobalSuccessRate * 100.f] : [NSNull null];
        [forehandProgress addObject:obj];
    }
    
    return forehandProgress;
}

+ (NSMutableArray *)selectBackhandProgressFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *backhandProgress = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.backhandGlobalSuccessRate > -1 ? [NSNumber numberWithFloat:statisticalDO.backhandGlobalSuccessRate * 100.f] : [NSNull null];
        [backhandProgress addObject:obj];
    }
    
    return backhandProgress;
}

+ (NSMutableArray *)selectServiceProgressFromResult:(NSMutableArray<StatisticalDO*>*)result
{
    NSMutableArray *serviceProgress = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < result.count; i++)
    {
        StatisticalDO *statisticalDO = (StatisticalDO *)[result objectAtIndex:i];
        id obj = statisticalDO.serviceGlobalSuccessRate > -1 ? [NSNumber numberWithFloat:statisticalDO.serviceGlobalSuccessRate * 100.f] : [NSNull null];
        [serviceProgress addObject:obj];
    }
    
    return serviceProgress;
}

@end
