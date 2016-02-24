//
//  LQAnimationTCL.m
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQAnimationTCL.h"
#import "LQTitleCell.h"
#import "LQTransformVCL.h"
@interface LQAnimationTCL ()

@end

@implementation LQAnimationTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDataSource];
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源

- (void)addDataSource
{
    NSArray *array = [NSArray arrayWithObjects:@"Transform",@"Scale",@"Rotation",@"Bounce",@"Flip", nil];
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQTransformVCL" bundle:nil];
    LQTransformVCL *transform = [storyboard instantiateViewControllerWithIdentifier:@"LQTransformVCL"];
    if (indexPath.row == 0) {
        [transform setValue:@{@"animation":@"transform"} forKey:@"params"];
    } else if (indexPath.row == 1) {
        [transform setValue:@{@"animation":@"scale"} forKey:@"params"];
    } else if (indexPath.row == 2) {
        [transform setValue:@{@"animation":@"rotation"} forKey:@"params"];
    } else if (indexPath.row == 3) {
        [transform setValue:@{@"animation":@"bounce"} forKey:@"params"];
    } else if (indexPath.row == 4) {
        [transform setValue:@{@"animation":@"flip"} forKey:@"params"];
    }
    [self.navigationController pushViewController:transform animated:YES];
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
