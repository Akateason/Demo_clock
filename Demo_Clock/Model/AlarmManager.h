//
//  AlarmManager.h
//  Demo_Clock
//
//  Created by TuTu on 16/1/4.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmManager : NSObject

+ (AlarmManager *)shareInstance ;

@property (nonatomic,strong) NSDate *alarmTime ;
- (void)getAlarmDeta ;

@end
