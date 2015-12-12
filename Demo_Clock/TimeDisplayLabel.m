//
//  TimeDisplayLabel.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "TimeDisplayLabel.h"
#import "NSDate+Addition.h"
#import "NSString+NumInClock.h"

@implementation TimeDisplayLabel

- (void)setTime:(NSDate *)time
{
    _time = time ;
    
    int hour = [time getHour] ;
    int minute = [time getMinute] ;
    int second = [time getSecond] ;
    
    self.text = [NSString stringWithFormat:@"%@ : %@ : %@" ,
                  [NSString numberDisplayInClock:hour] ,
                  [NSString numberDisplayInClock:minute] ,
                  [NSString numberDisplayInClock:second]] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
