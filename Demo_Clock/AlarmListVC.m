//
//  AlarmListVC.m
//  Demo_Clock
//
//  Created by teason23 on 2018/3/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "AlarmListVC.h"
#import "NSDate+Add.h"
#import "Alarm.h"
#import "AlarmCell.h"
#import "AddAlarmVC.h"
#import "ReactiveObjC.h"

@interface AlarmListVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (copy,nonatomic) NSArray *datasource ;
@end

@implementation AlarmListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [Alarm createTable] ;
    self.datasource = [Alarm selectAll] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addOnClick:(id)sender {
    [self performSegueWithIdentifier:@"list2add" sender:nil] ;
}

#pragma mark - UITable

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmCell"] ;
    [cell configure:self.datasource[indexPath.row]] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AlarmCell cellHeight] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"list2add"]) {
        AddAlarmVC *addVC = [segue destinationViewController] ;
        addVC.addPopSignal = [RACReplaySubject replaySubjectWithCapacity:1] ;
        @weakify(self)
        [addVC.addPopSignal subscribeNext:^(Alarm *x) {
            @strongify(self)
            NSMutableArray *tmplist = [self.datasource mutableCopy] ;
            [tmplist addObject:x] ;
            self.datasource = tmplist ;
            [self.table reloadData] ;
        }] ;
    }        
}


@end
