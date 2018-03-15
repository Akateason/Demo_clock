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
#import "NSDate+Add.h"
#import "XTlib.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property (nonatomic, strong) ClockFace *clockFace ;
@property (nonatomic, strong) TimeDisplayLabel *timeLabel ;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self clockFace] ;
    [self timeLabel] ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
    
//    self.clockFace.time = nil ;
    [self setupTimer] ;
}

- (void)setupTimer
{
    @weakify(self)
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
      takeUntil:[self rac_signalForSelector:@selector(viewWillDisappear:)]]
     subscribeNext:^(NSDate * _Nullable x) {
         
         @strongify(self)
         self.clockFace.time = x ;
         self.timeLabel.time = x ;
         
     }] ;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
