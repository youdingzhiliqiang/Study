//
//  LQLayoutConstraintVCL.m
//  Study
//
//  Created by 李强 on 16/7/8.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQLayoutConstraintVCL.h"

@interface LQLayoutConstraintVCL ()

@end

@implementation LQLayoutConstraintVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    //纯代码为view新增nslayoutconstraint约束
    [self createTestView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - 创建测试view

- (void)createTestView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    //添加宽度约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
    [view addConstraint:widthConstraint];
    //添加高度约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:300];
    [view addConstraint:heightConstraint];
    //添加左边约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:50];
    [self.view addConstraint:leftConstraint];
    //添加TOP约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
    [self.view addConstraint:topConstraint];
}

#pragma mark - 创建两个测试试图

//- (void)createTwoTestView
//{
//    UIView *purpleView
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
