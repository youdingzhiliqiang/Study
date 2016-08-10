//
//  LQPersonDetailVCL.m
//  Study
//
//  Created by 李强 on 16/7/26.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQPersonDetailVCL.h"

@interface LQPersonDetailVCL ()

@end

@implementation LQPersonDetailVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    self.title = @"这是一个oc页面";
    [self createLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建label

- (void)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 50);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.params[@"text"];
    label.center = self.view.center;
    [self.view addSubview:label];
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
