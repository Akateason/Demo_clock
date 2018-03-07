//
//  AlarmCell.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "AlarmCell.h"
#import "Alarm.h"
#import "XTlib.h"

@implementation AlarmCell

- (IBAction)swtOnClick:(UISwitch *)sender {
    sender.on = !sender.on ;
    
    Alarm *alarm = self.model ;
    alarm.isOn = sender.on ;
    [alarm update] ;
}

+ (CGFloat)cellHeight {
    return 70. ;
}

- (void)configure:(Alarm *)alarm {
    [super configure:alarm] ;
    
    _lbName.text = [[alarm alarmDate] xt_getStrWithFormat:@"HH:mm"] ;
    _swt.on = alarm.isOn ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
