//
//  AddAlarmVC.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "AddAlarmVC.h"
#import "NSDate+Add.h"
#import "Alarm.h"
#import "TimeDisplayLabel.h"
#import "ReactiveObjC.h"
#import <UserNotifications/UserNotifications.h>
#import "XTlib.h"

@interface AddAlarmVC ()
@property (nonatomic, strong) UIDatePicker *datePicker ;
@property (weak, nonatomic) IBOutlet TimeDisplayLabel *lbChooseTime;

@end

@implementation AddAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    [self showDatePicker] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveOnClick:(id)sender {
    
    Alarm *alarm = [[Alarm alloc] initWithName:[self.datePicker.date getHHMMString]
                                          time:self.datePicker.date] ;
    [alarm insert] ;
    [self.addPopSignal sendNext:alarm] ;
    [self.addPopSignal sendCompleted] ;
    [self.navigationController popViewControllerAnimated:YES] ;
    
    // add notification
    //每周一早上8：00触发  UNCalendarNotificationTrigger
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    components.hour = [[alarm alarmDate] getHour] ;
    components.minute = [[alarm alarmDate] getMinute] ;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES] ;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:alarm.name arguments:nil] ;
//    content.body = [NSString localizedUserNotificationStringForKey:LOCALIZE(@"cootek_sign_remind_go")
//                                                         arguments:nil] ;
    content.sound = [UNNotificationSound defaultSound] ;
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:STR_FORMAT(@"%d",alarm.pkid)
                                                                          content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }] ;
}


- (void)showDatePicker {
    NSString *string = [[NSDate date] xt_getStrWithFormat:kTIME_STR_FORMAT_5] ;
    NSDate *theDate = [NSDate xt_getDateWithStr:string format:kTIME_STR_FORMAT_5] ;
    
    [self.datePicker setDate:theDate animated:YES] ;
    [self.lbChooseTime setMMDD:self.datePicker.date] ;
    [self.view addSubview:self.datePicker] ;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init] ;
        _datePicker.datePickerMode = UIDatePickerModeTime ;
        _datePicker.backgroundColor = [UIColor whiteColor] ;
        [_datePicker addTarget:self action:@selector(dateValueChanged) forControlEvents:UIControlEventValueChanged] ;
        if (![_datePicker superview]) {
            CGRect datepickerRect = CGRectZero ;
            datepickerRect.size = CGSizeMake(self.view.bounds.size.width, 216) ;
            datepickerRect.origin.y = self.view.bounds.size.height - 216 ;
            _datePicker.frame = datepickerRect ;
        }
    }
    return _datePicker ;
}

- (void)dateValueChanged {
    NSString *strSelect = [NSString stringWithFormat:@"%@ valuechanged",[self.datePicker.date getTimeString]] ;
    NSLog(@"%@",strSelect) ;
    [self.lbChooseTime setMMDD:self.datePicker.date] ;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
