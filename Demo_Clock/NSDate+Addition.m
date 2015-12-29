//
//  NSDate+Addition.m
//  SuBaoJiang
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "NSDate+Addition.h"
#import "NSString+NumInClock.h"


@implementation NSDate (Addition)

- (NSDateComponents *)shareComps
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps;
}

- (int)getYear
{
    NSDateComponents *comps = [self shareComps];
    NSInteger year = [comps year] ;
    return (int)year ;
}

- (int)getMonth
{
    NSDateComponents *comps = [self shareComps];
    NSInteger month = [comps month] ;
    return (int)month ;
}

- (int)getDay
{
    NSDateComponents *comps = [self shareComps];
    NSInteger day = [comps day] ;
    return (int)day ;
}

- (int)getHour
{
    NSDateComponents *comps = [self shareComps];
    NSInteger hour = [comps hour] ;
    return (int)hour ;
}

- (int)getMinute
{
    NSDateComponents *comps = [self shareComps];
    NSInteger minute = [comps minute] ;
    return (int)minute ;
}

- (int)getSecond
{
    NSDateComponents *comps = [self shareComps];
    NSInteger second = [comps second] ;
    return (int)second ;
}

+ (int)daysInMonth:(int)imonth year:(int)year
{
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

- (NSString *)getTimeString
{
    int hour = [self getHour] ;
    int minute = [self getMinute] ;
    int second = [self getSecond] ;
    
    return [NSString stringWithFormat:@"%@ : %@ : %@" ,
                 [NSString numberDisplayInClock:hour] ,
                 [NSString numberDisplayInClock:minute] ,
                 [NSString numberDisplayInClock:second]] ;
}

@end
