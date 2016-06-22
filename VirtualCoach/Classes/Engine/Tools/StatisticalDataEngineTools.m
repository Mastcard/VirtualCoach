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
        [forehandCounts addObject:[NSNumber numberWithInt:statisticalDO.forehandCount]];
    }
    
    return forehandCounts;
}

@end
