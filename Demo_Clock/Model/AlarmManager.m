//
//  AlarmManager.m
//  Demo_Clock
//
//  Created by TuTu on 16/1/4.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "AlarmManager.h"

@implementation AlarmManager
@synthesize alarmTime = _alarmTime ;

static AlarmManager *instance ;
static dispatch_once_t onceToken ;

+ (AlarmManager *)shareInstance
{
    if (!instance) {
        dispatch_once(&onceToken, ^{
            instance = [[AlarmManager alloc] init] ;
        }) ;
    }
    return instance ;
}
#pragma mark - Property
- (void)setAlarmTime:(NSDate *)alarmTime
{
    _alarmTime = alarmTime ;
    
    本地化存储?
}

- (NSDate *)alarmTime
{
    if (_alarmTime) {
        // 从本地里先获取, 若没有 , 则返回nil
    }
    
    return <#expression#>
}

#pragma mark - Public
- (void)foregroundAlarm
{
    
}

- (void)backgroundAlarm
{
    // get time deta .
    
    
}

- (void)getAlarmDeta
{
    if (![AlarmManager shareInstance].alarmTime) return ;
    NSDate *timeWillAlarm = [AlarmManager shareInstance].alarmTime ;
    
    
}

@end
