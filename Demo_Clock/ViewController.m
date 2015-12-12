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

@interface ViewController ()
@property (nonatomic, strong) ClockFace *clockFace ;
@property (nonatomic, strong) TimeDisplayLabel *timeLabel ;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.clockFace = [[ClockFace alloc] init] ;
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2) ;
    [self.view.layer addSublayer:self.clockFace] ;
    
    self.timeLabel = [[TimeDisplayLabel alloc] init] ;
    CGRect timeLbRect = CGRectZero ;
    timeLbRect.size = CGSizeMake(200, 20) ;
    self.timeLabel.frame = timeLbRect ;
    self.timeLabel.center = CGPointMake((self.view.bounds.size.width) / 2, 100 + timeLbRect.size.height / 2) ;
    self.timeLabel.font = [UIFont systemFontOfSize:18.0] ;
    [self.view addSubview:self.timeLabel] ;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(clockMove)
                                                    userInfo:nil
                                                     repeats:YES] ;
    [timer fire] ;
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
