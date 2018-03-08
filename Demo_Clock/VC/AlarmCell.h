//
//  AlarmCell.h
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "RootTableCell.h"

@interface AlarmCell : RootTableCell
@property (weak, nonatomic) IBOutlet UISwitch *swt;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
