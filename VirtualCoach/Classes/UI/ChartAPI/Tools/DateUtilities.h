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

+ (NSInteger)monthForTitle:(NSString *)title;

+ (NSString *)currentDateFullTitle;
+ (NSString *)currentMonthFullTitle;
+ (NSString *)currentYearFullTitle;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSString *)stringWithDate:(NSDate *)date;

+ (NSDictionary *)startAndEndDateOfWeekForDate:(NSDate *)date;

+ (NSInteger)currentDay;
+ (NSInteger)currentMonth;
+ (NSInteger)currentYear;

+ (NSString *)monthFullTitle:(NSInteger)month;
+ (NSString *)yearFullTitle:(NSInteger)year;

+ (NSString *)monthFullTitle:(NSInteger)month forYear:(NSInteger)year;

@end
