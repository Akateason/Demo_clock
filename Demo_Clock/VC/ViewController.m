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
    // Do any additional setup after loading the view, typically from a nib.
    
    [self clockFace] ;
    [self timeLabel] ;
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
