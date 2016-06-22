//
//  StatisticalDataEngineTools.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticalDO.h"

@interface StatisticalDataEngineTools : NSObject

+ (NSMutableArray *)selectForehandCountsFromResult:(NSMutableArray<StatisticalDO*>*)result;

@end
