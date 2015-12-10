//
//  ViewController.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/10.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "ClockFace.h"

@interface ViewController ()
@property (nonatomic, strong) ClockFace *clockFace;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.clockFace = [[ClockFace alloc] init] ;
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.view.layer addSublayer:self.clockFace];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockMove) userInfo:nil repeats:YES] ;
    [timer fire] ;
}

- (void)clockMove
{
    self.clockFace.time = [NSDate date] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
