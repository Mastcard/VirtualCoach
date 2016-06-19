//
//  DateUtilities.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "DateUtilities.h"

@implementation DateUtilities

+ (NSUInteger)dayCountForMonth:(NSInteger)month
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay
                              inUnit:NSCalendarUnitMonth
                             forDate:[cal dateFromComponents:comps]];
    
    return range.length;
}

+ (NSUInteger)dayCountForCurrentMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    
    return rng.length;
}

+ (NSArray *)dayTitlesForMonth:(NSInteger)month
{
    NSInteger dayCount = [DateUtilities dayCountForMonth:month];
    
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:dayCount];
    
    for (NSUInteger i = 1; i <= dayCount; i++)
        [res addObject:[NSString stringWithFormat:@"%d", (int)i]];
    
    return res;
}

+ (NSArray *)dayTitlesForCurrentMonth
{
    NSInteger dayCount = [DateUtilities dayCountForCurrentMonth];
    
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:dayCount];
    
    for (NSUInteger i = 1; i <= dayCount; i++)
        [res addObject:[NSString stringWithFormat:@"%d", (int)i]];
    
    return res;
}

+ (NSArray *)monthTitles
{
    return [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
}

+ (NSArray *)dayTitles
{
    return [NSArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
}

+ (NSString *)monthFullTitle:(NSInteger)month
{
    switch (month)
    {
        case 1:
            return @"January";
            break;
            
        case 2:
            return @"February";
            break;
            
        case 3:
            return @"March";
            break;
            
        case 4:
            return @"April";
            break;
            
        case 5:
            return @"May";
            break;
            
        case 6:
            return @"June";
            break;
            
        case 7:
            return @"July";
            break;
            
        case 8:
            return @"August";
            break;
            
        case 9:
            return @"September";
            break;
            
        case 10:
            return @"October";
            break;
            
        case 11:
            return @"November";
            break;
            
        case 12:
            return @"December";
            break;
            
        default:
            break;
    }
    
    return @"";
}

+ (NSInteger)monthForTitle:(NSString *)title
{
    NSInteger month = -1;
    
    if ([title isEqualToString:@"Jan"] || [title isEqualToString:@"January"])
        month = 1;
    
    else if ([title isEqualToString:@"Feb"] || [title isEqualToString:@"February"])
        month = 2;
    
    else if ([title isEqualToString:@"Mar"] || [title isEqualToString:@"March"])
        month = 3;
    
    else if ([title isEqualToString:@"Apr"] || [title isEqualToString:@"April"])
        month = 4;
    
    else if ([title isEqualToString:@"May"])
        month = 5;
    
    else if ([title isEqualToString:@"Jun"] || [title isEqualToString:@"June"])
        month = 6;
    
    else if ([title isEqualToString:@"Jul"] || [title isEqualToString:@"July"])
        month = 7;
    
    else if ([title isEqualToString:@"Aug"] || [title isEqualToString:@"August"])
        month = 8;
    
    else if ([title isEqualToString:@"Sep"] || [title isEqualToString:@"September"])
        month = 9;
    
    else if ([title isEqualToString:@"Oct"] || [title isEqualToString:@"October"])
        month = 10;
    
    else if ([title isEqualToString:@"Nov"] || [title isEqualToString:@"November"])
        month = 11;
    
    else if ([title isEqualToString:@"Dec"] || [title isEqualToString:@"December"])
        month = 12;
    
    
    return month;
}

+ (NSString *)yearFullTitle:(NSInteger)year
{
    return [NSString stringWithFormat:@"%ld", (long)year];
}

+ (NSString *)monthFullTitle:(NSInteger)month forYear:(NSInteger)year
{
    NSString *monthName = [DateUtilities monthFullTitle:month];
    return [NSString stringWithFormat:@"%@ %@", monthName, [DateUtilities yearFullTitle:year]];
}

+ (NSString *)currentDateFullTitle
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%ld/%ld/%ld", (long)year, (long)month, (long)day];
}

//+ (NSString *)currentWeekFullTitleForMonth
//{
//
//}

+ (NSInteger)currentDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    return [components day];
}

+ (NSInteger)currentMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    return [components month];
}

+ (NSInteger)currentYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    return [components year];
}

+ (NSString *)currentMonthFullTitle
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    
    return [NSString stringWithFormat:@"%ld", (long)month];
}

+ (NSString *)currentYearFullTitle
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%ld", (long)year];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [cal dateFromComponents:comps];
}

+ (NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    return [dateFormatter stringFromDate:date];
}

+ (NSDictionary *)startAndEndDateOfWeekForDate:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = date;
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    [cal rangeOfUnit:NSCalendarUnitWeekOfMonth
           startDate:&startOfTheWeek
            interval:&interval
             forDate:now];
    
    endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:startOfTheWeek, @"startDate", endOfWeek, @"endDate", nil];
}

@end
