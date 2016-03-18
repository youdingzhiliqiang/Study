//
//  LQThirdTCL.m
//  Study
//
//  Created by 李强 on 16/3/7.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQThirdTCL.h"
#import "LQTitleCell.h"
#import "LQShowVCL.h"
@interface LQThirdTCL ()

@end

@implementation LQThirdTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加数据源

- (void)addDataSource
{
    self.isFirstLoadData = YES;
    [self.dataArray removeAllObjects];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"页面三：%d",i];
        [self.dataArray addObject:str];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - tableview 添加刷新

- (void)addRefresh
{
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
        [self addDataSource];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQTitleCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQShowVCL *showVCL = [self.storyboard instantiateViewControllerWithIdentifier:@"LQShowVCL"];
    [showVCL setValue:@{@"fromVCL":@"第三个页面而来",@"fromLine":[NSString stringWithFormat:@"第%d行而来",(int)indexPath.row+1]} forKey:@"params"];
    [self.navigationController pushViewController:showVCL animated:YES];
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
