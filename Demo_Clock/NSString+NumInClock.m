//
//  NSString+NumInClock.m
//  Demo_Clock
//
//  Created by TuTu on 15/12/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "NSString+NumInClock.h"

@implementation NSString (NumInClock)

+ (NSString *)numberDisplayInClock:(int)number
{
    NSString *strNumber = [NSString stringWithFormat:@"%d",number] ;
    if (number < 10) {
        return [@"0" stringByAppendingString:strNumber] ;
    }
    return strNumber ;
}

@end
