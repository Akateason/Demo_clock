//
//  TimeDisplayLabel.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "TimeDisplayLabel.h"
#import "NSDate+Add.h"

@implementation TimeDisplayLabel

- (void)setTime:(NSDate *)time {
    self.text = [time getTimeString] ;
}

- (void)setMMDD:(NSDate *)mmdd {
    self.text = [mmdd getHHMMString] ;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
