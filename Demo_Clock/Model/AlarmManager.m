//
//  AlarmManager.m
//  Demo_Clock
//
//  Created by TuTu on 16/1/4.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "AlarmManager.h"

@implementation AlarmManager

static AlarmManager *instance ;
static dispatch_once_t onceToken ;

+ (AlarmManager *)shareInstance
{
    if (!instance) {
        dispatch_once(&onceToken, ^{
            instance = [[AlarmManager alloc] init] ;
        }) ;
    }
    return instance ;
}

@end
