//
//  Alarm.h
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import <XTFMDB/XTFMDB.h>

@interface Alarm : XTDBModel

@property (copy,nonatomic)      NSString *name ;
@property (strong,nonatomic)    NSString *alarmDateString ;
@property (nonatomic)           BOOL     isOn ;

- (NSDate *)alarmDate ;

- (instancetype)initWithName:(NSString *)name
                        time:(NSDate *)date ;

@end
