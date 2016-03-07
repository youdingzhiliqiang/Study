//
//  LQMainTCL.m
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQMainTCL.h"
#import "LQTitleCell.h"
#import "LQAnimationTCL.h"
#import "LQCodingVCL.h"
#import "LQCoredataVCL.h"
#import "LQImageCacheVCL.h"
#import "LQMultiThreadTCL.h"
#import "LQBlockVCL.h"
#import "LQTablePageVCL.h"
@interface LQMainTCL ()

@end

@implementation LQMainTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDataSource];
    LQDataModelSingle *dm = [LQDataModelSingle sharedInstance];
    [dm archive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源

- (void)addDataSource
{
    NSArray *array = [NSArray arrayWithObjects:@"Animation",@"NSCoding",@"Coredata",@"ImageCache",@"MultiThread",@"Block",@"TablePage", nil];
    self.dataArray = nil;
    self.dataArray = [[NSMutableArray alloc] initWithArray:array];
}

#pragma mark - tableview的代理函数
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
    return 0.0000001;
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQAnimationTCL" bundle:nil];
        LQAnimationTCL *animation = [storyboard instantiateViewControllerWithIdentifier:@"LQAnimationTCL"];
        [self.navigationController pushViewController:animation animated:YES];
    } else if (indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQCodingVCL" bundle:nil];
        LQCodingVCL *codingVCL = [storyboard instantiateViewControllerWithIdentifier:@"LQCodingVCL"];
        [self.navigationController pushViewController:codingVCL animated:YES];
    } else if (indexPath.row == 2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQCoredataVCL" bundle:nil];
        LQCoredataVCL *coredataVCL = [storyboard instantiateViewControllerWithIdentifier:@"LQCoredataVCL"];
        [self.navigationController pushViewController:coredataVCL animated:YES];
    } else if (indexPath.row == 3) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQImageCacheVCL" bundle:nil];
        LQImageCacheVCL *imageCache = [storyboard instantiateViewControllerWithIdentifier:@"LQImageCacheVCL"];
        [self.navigationController pushViewController:imageCache animated:YES];
    } else if (indexPath.row == 4) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQMainTCL" bundle:nil];
        LQMultiThreadTCL *multiThread = [storyboard instantiateViewControllerWithIdentifier:@"LQMultiThreadTCL"];
        [self.navigationController pushViewController:multiThread animated:YES];
    } else if (indexPath.row == 5) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQBlockVCL" bundle:nil];
        LQBlockVCL *block = [storyboard instantiateViewControllerWithIdentifier:@"LQBlockVCL"];
        [self.navigationController pushViewController:block animated:YES];
    } else if (indexPath.row == 6) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQTablePageVCL" bundle:nil];
        LQTablePageVCL *pageVCL = [storyboard instantiateViewControllerWithIdentifier:@"LQTablePageVCL"];
        [self.navigationController pushViewController:pageVCL animated:YES];
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
