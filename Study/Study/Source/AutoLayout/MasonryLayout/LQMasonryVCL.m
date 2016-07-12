//
//  LQMasonryVCL.m
//  Study
//
//  Created by 李强 on 16/7/12.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQMasonryVCL.h"

@interface LQMasonryVCL ()

@end

@implementation LQMasonryVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加返回按钮
    [self addBackButton];
    
    //创建测试视图
    [self createTestView];
    
    //创建两个相等尺寸的view
    [self createTwoEqulSizeView];
    
    //利用autolayout创建两个相同尺寸的view
    [self createTwoEqulSizeWithAutoLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建测试视图

- (void)createTestView
{
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:testView];
    
    UIEdgeInsets edges = UIEdgeInsetsMake(74, 10,SCREEN_HEIGHT - 74 - 50, 10);
   // 添加约束
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(edges.left);
        make.top.equalTo(self.view.mas_top).with.offset(edges.top);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-edges.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-edges.right);
        make.height.mas_lessThanOrEqualTo(100);
        make.width.greaterThanOrEqualTo(@200);
    }];
    
    [testView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(edges);
    }];
}

#pragma mark - 创建两个视图

- (void)createTwoEqulSizeView
{
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:purpleView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(redView.mas_left).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(purpleView.mas_width);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
        make.left.equalTo(purpleView.mas_right).offset(10);
    }];
    
}

#pragma mark - nsautolayout 创建两个相等尺寸的view
- (void)createTwoEqulSizeWithAutoLayout
{
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    purpleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:purpleView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.view addConstraint:leftConstraint];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100];
    [self.view addConstraint:bottomConstraint];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:50];
    [purpleView addConstraint:heightConstraint];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.view addConstraint:widthConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10];
    [self.view addConstraint:rightConstraint];
    
    
    NSLayoutConstraint *redViewLeftConstraint = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:purpleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:10];
    [self.view addConstraint:redViewLeftConstraint];

    NSLayoutConstraint *redViewHeightConstraint = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:50];
    [redView addConstraint:redViewHeightConstraint];

    NSLayoutConstraint *redViewBottomConstraint = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100];
    [self.view addConstraint:redViewBottomConstraint];

    NSLayoutConstraint *redViewRightConstraint = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    [self.view addConstraint:redViewRightConstraint];
    
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
