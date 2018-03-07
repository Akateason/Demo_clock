//
//  AddAlarmVC.h
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "RootCtrl.h"
@class RACReplaySubject ;

@interface AddAlarmVC : RootCtrl
@property (strong,nonatomic) RACReplaySubject *addPopSignal ;
@end
