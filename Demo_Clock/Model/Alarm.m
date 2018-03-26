//
//  Alarm.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "Alarm.h"
#import "NSDate+XTTick.h"
#import <UserNotifications/UserNotifications.h>
#import "XTlib.h"
#import "NSDate+Add.h"

@interface Alarm () <UNUserNotificationCenterDelegate>

@end

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

- (void)editWithName:(NSString *)name
                date:(NSDate *)date
                 swt:(BOOL)swt
{
    if (name) self.name = name ;
    if (date) self.alarmDateString =  [date xt_getStrWithFormat:kTIME_STR_FORMAT_5] ;
    if (name) self.isOn = swt ;
}

- (NSDate *)alarmDate {
    return [NSDate xt_getDateWithStr:self.alarmDateString format:kTIME_STR_FORMAT_5] ;
}

- (void)start {
    // add notification
    //每周一早上8：00触发  UNCalendarNotificationTrigger //周年月日等.
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    components.hour      = [[self alarmDate] getHour] ;
    components.minute    = [[self alarmDate] getMinute] ;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES] ;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter] ;
    center.delegate = self ;
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init] ;
    content.title = [NSString localizedUserNotificationStringForKey:self.name arguments:nil] ;
//    content.body = [NSString localizedUserNotificationStringForKey:LOCALIZE(@"cootek_sign_remind_go") arguments:nil] ;
    content.sound = [UNNotificationSound defaultSound] ;
    content.badge = @1 ;
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1 ;
    UNNotificationRequest* request =
    [UNNotificationRequest requestWithIdentifier:STR_FORMAT(@"%d",self.pkid)
                                         content:content
                                         trigger:trigger] ;
    
    [center addNotificationRequest:request
             withCompletionHandler:^(NSError * _Nullable error) {
            
    }] ;
    
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    completionHandler(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) ;
    
//    NSLog(@"dddddd") ;
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1 ;
}


- (void)close {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter] ;
    [center removePendingNotificationRequestsWithIdentifiers:@[STR_FORMAT(@"%d",self.pkid)]] ;
}

@end
