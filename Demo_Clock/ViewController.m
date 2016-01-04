//
//  ViewController.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/10.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "ClockFace.h"
#import "TimeDisplayLabel.h"
#import "NSDate+Addition.h"
#import "AlarmManager.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (nonatomic, strong) ClockFace *clockFace ;
@property (nonatomic, strong) TimeDisplayLabel *timeLabel ;
@property (nonatomic, strong) UIButton *btAlarm ;
@property (nonatomic, strong) UIDatePicker *datePicker ;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        ((AppDelegate *)[UIApplication sharedApplication].delegate).mainVC = self ;
    }
    return self;
}

- (ClockFace *)clockFace
{
    if (!_clockFace) {
        _clockFace = [[ClockFace alloc] init] ;
        if (![_clockFace superlayer]) {
            _clockFace.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2) ;
            [self.view.layer addSublayer:_clockFace] ;
        }
    }
    return _clockFace ;
}

- (TimeDisplayLabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[TimeDisplayLabel alloc] init] ;
        if (![_timeLabel superview]) {
            CGRect timeLbRect = CGRectZero ;
            timeLbRect.size = CGSizeMake(110, 20) ;
            _timeLabel.frame = timeLbRect ;
            _timeLabel.center = CGPointMake((self.view.bounds.size.width) / 2, 100 + timeLbRect.size.height / 2) ;
            _timeLabel.font = [UIFont boldSystemFontOfSize:20.0] ;
            [self.view addSubview:_timeLabel] ;
        }
    }
    return _timeLabel ;
}

- (UIButton *)btAlarm
{
    if (!_btAlarm) {
        _btAlarm = [[UIButton alloc] init] ;
        [_btAlarm setTitle:@"想要闹钟?" forState:0] ;
        [_btAlarm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [_btAlarm setTitleColor:[UIColor redColor] forState:UIControlStateSelected] ;
        [_btAlarm sizeToFit] ;
        
        if (![_btAlarm superview]) {
            CGRect alermFrame = CGRectZero ;
            alermFrame.size = CGSizeMake(self.view.bounds.size.width, 40) ;
            _btAlarm.frame = alermFrame;
            [self.view addSubview:_btAlarm] ;
            _btAlarm.center = CGPointMake(self.view.bounds.size.width / 2, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 40 + 10) ;
        }
        [_btAlarm addTarget:self action:@selector(dealBtAlarm) forControlEvents:UIControlEventTouchUpInside] ;
    }
    return _btAlarm ;
}

- (void)dealBtAlarm
{
    if ([self.datePicker superview]) return ;

    if (!self.btAlarm.selected) {
        [self showDatePicker] ;
    }
    else {
        [self askConfirmToChangeAlarmTime] ;
    }
}

- (void)showDatePicker
{
    [self.datePicker setDate:[NSDate date] animated:YES] ;
    self.datePicker.alpha = 0 ;
    [self.view addSubview:self.datePicker] ;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.backgroundColor = [UIColor darkGrayColor] ;
        self.datePicker.alpha = 1 ;
        [self.btAlarm setTitleColor:[UIColor whiteColor] forState:0] ;
    } completion:^(BOOL finished) {
    }] ;
}

- (void)askConfirmToChangeAlarmTime
{
    UIAlertController *alertCtrller = [UIAlertController alertControllerWithTitle:@"确认要更改闹钟的时间了吗?!?!?" message:@"呵呵哒" preferredStyle:UIAlertControllerStyleAlert] ;
    [alertCtrller addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.btAlarm.selected = NO ;
        [self showDatePicker] ;
    }]] ;
    [alertCtrller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]] ;
    [self presentViewController:alertCtrller animated:YES completion:nil];
}

- (UIDatePicker *)datePicker
{
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

- (void)dateValueChanged
{
    NSString *strNomarl = [NSString stringWithFormat:@"我要设置%@的闹钟了哦",[self.datePicker.date getTimeString]] ;
    [self.btAlarm setTitle:strNomarl forState:UIControlStateNormal] ;
    NSString *strSelect = [NSString stringWithFormat:@"%@的闹钟已经设置!",[self.datePicker.date getTimeString]] ;
    [self.btAlarm setTitle:strSelect forState:UIControlStateSelected] ;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.datePicker isExclusiveTouch] && [self.datePicker superview])
    {
        UIAlertController *alertCtrller = [UIAlertController alertControllerWithTitle:@"确定设置闹钟的时间了吗?!?!?" message:@"嘻嘻" preferredStyle:UIAlertControllerStyleAlert] ;
        [alertCtrller addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self confirmSetAlarm] ;
        }]] ;
        [alertCtrller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSString *strSelect = [NSString stringWithFormat:@"%@的闹钟已经设置!",[[AlarmManager shareInstance].alarmTime getTimeString]] ;
            [self.btAlarm setTitle:strSelect forState:UIControlStateSelected] ;
            [self letDatePickerDisappear] ;
            self.btAlarm.selected = YES ;
        }]] ;
        [self presentViewController:alertCtrller animated:YES completion:nil];
    }
}

- (void)confirmSetAlarm
{
    [self.btAlarm setTitle:nil forState:UIControlStateNormal] ;
    [AlarmManager shareInstance].alarmTime = self.datePicker.date ;
    self.btAlarm.selected = YES ;
    
    [self letDatePickerDisappear] ;
}

- (void)letDatePickerDisappear
{
    [self.datePicker removeFromSuperview] ;
    [UIView animateWithDuration:1.0
                     animations:^{
        self.datePicker.alpha = 0 ;
        self.view.backgroundColor = [UIColor whiteColor] ;
        [self.btAlarm setTitleColor:[UIColor blackColor] forState:0] ;
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                         }
    }] ;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self clockFace] ;
    [self timeLabel] ;
    [self btAlarm] ;
    [self setupTimer] ;
}

- (void)setupTimer
{
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:1
                                                                          target:self
                                                                        selector:@selector(clockMove)
                                                                        userInfo:nil
                                                                         repeats:YES]
                                 forMode:NSRunLoopCommonModes] ;
}

- (void)clockMove
{
    NSDate *now = [NSDate date] ;
    self.clockFace.time = now ;
    self.timeLabel.time = now ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
