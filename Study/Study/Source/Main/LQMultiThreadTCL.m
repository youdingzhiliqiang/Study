//
//  LQMultiThreadTCL.m
//  Study
//
//  Created by 李强 on 16/3/3.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQMultiThreadTCL.h"
#import "LQTitleCell.h"
#import "LQGcdVCL.h"
@interface LQMultiThreadTCL ()

@end

@implementation LQMultiThreadTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加数据源

- (void)addDataSource
{
    self.dataArray = nil;
    NSArray *array = [[NSArray alloc] initWithObjects:@"GCD", nil];
    self.dataArray = [[NSMutableArray alloc] initWithArray:array];
}

#pragma mark - tableView的代理函数

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
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQTitleCell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQGcdVCL" bundle:nil];
        LQGcdVCL *gcdVCL = [storyboard instantiateViewControllerWithIdentifier:@"LQGcdVCL"];
        [self.navigationController pushViewController:gcdVCL animated:YES];
    }
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
