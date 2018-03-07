//
//  Alarm.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "Alarm.h"
#import "NSDate+XTTick.h"

@implementation Alarm

- (instancetype)initWithName:(NSString *)name
                        time:(NSDate *)date
{
    self = [super init];
    if (self) {
        _name = name ;
        _alarmDateString = [date xt_getStrWithFormat:kTIME_STR_FORMAT_5] ;
        _isOn = YES ;
    }
    return self;
}

- (NSDate *)alarmDate {
    return [NSDate xt_getDateWithStr:self.alarmDateString format:kTIME_STR_FORMAT_5] ;
}

@end
