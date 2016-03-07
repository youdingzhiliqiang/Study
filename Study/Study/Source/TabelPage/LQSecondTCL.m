//
//  LQSecondTCL.m
//  Study
//
//  Created by 李强 on 16/3/7.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQSecondTCL.h"
#import "LQTitleCell.h"
@interface LQSecondTCL ()

@end

@implementation LQSecondTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRefresh];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加数据源

- (void)addDataSource
{
    [self.dataArray removeAllObjects];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"页面二：%d",i];
        [self.dataArray addObject:str];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - tableview 添加刷新

- (void)addRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self addDataSource];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQTitleCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
