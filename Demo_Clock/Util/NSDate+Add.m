//
//  NSDate+Add.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/5.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "NSDate+Add.h"
#import "XTlib.h"
#import "NSString+NumInClock.h"

@implementation NSDate (Add)

- (NSString *)getTimeString {
    int hour = [self getHour] ;
    int minute = [self getMinute] ;
    int second = [self getSecond] ;
    
    return [NSString stringWithFormat:@"%@ : %@ : %@" ,
            [NSString numberDisplayInClock:hour] ,
            [NSString numberDisplayInClock:minute] ,
            [NSString numberDisplayInClock:second]] ;
}

@end
