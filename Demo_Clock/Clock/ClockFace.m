//
//  ClockFace.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/10.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ClockFace.h"
#import <UIKit/UIKit.h>

@interface ClockFace ()

@property (nonatomic, strong) CAShapeLayer *hourHand ;
@property (nonatomic, strong) CAShapeLayer *minuteHand ;
@property (nonatomic, strong) CAShapeLayer *secondHand ;
@property (nonatomic, strong) CAShapeLayer *circle ;
@end

@implementation ClockFace

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.lineWidth = 4;
        
        self.hourHand = [CAShapeLayer layer];
        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-3, -55, 6, 65)].CGPath;
        self.hourHand.fillColor = [UIColor blackColor].CGColor;
        self.hourHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [CAShapeLayer layer];
        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 4, 80)].CGPath;
        self.minuteHand.fillColor = [UIColor blackColor].CGColor;
        self.minuteHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.minuteHand];
        
        self.secondHand = [CAShapeLayer layer] ;
        self.secondHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -85, 2, 100)].CGPath;
        self.secondHand.fillColor = [UIColor redColor].CGColor;
        self.secondHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.secondHand];
        
        self.circle = [CAShapeLayer layer] ;
        self.circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-5, -5, 10, 10) cornerRadius:5].CGPath ;
        self.circle.fillColor = [UIColor redColor].CGColor ;
        self.circle.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2); ;
        [self addSublayer:self.circle] ;
    }
    return self;
}

- (void)setTime:(NSDate *)time
{
    _time = time;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSCalendarUnitSecond
                                               fromDate:time];
    self.hourHand.affineTransform   = CGAffineTransformMakeRotation(components.hour / 12.0 * 2.0 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(components.minute / 60.0 * 2.0 * M_PI);
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(components.second / 60.0 * 2.0 * M_PI);
}



@end
