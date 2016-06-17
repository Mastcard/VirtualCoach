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

//+ (NSString *)titleForMonth:(NSInteger)month
//{
//    switch (<#expression#>)
//    {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
//}

@end
