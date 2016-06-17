//
//  DateUtilities.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtilities : NSObject

+ (NSUInteger)dayCountForMonth:(NSInteger)month;
+ (NSUInteger)dayCountForCurrentMonth;
+ (NSArray *)dayTitlesForMonth:(NSInteger)month;
+ (NSArray *)dayTitlesForCurrentMonth;
+ (NSArray *)monthTitles;
+ (NSArray *)dayTitles;

@end
