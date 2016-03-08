//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYAutoFooter.h"

@interface MJDIYAutoFooter()
@end

@implementation MJDIYAutoFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 60;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"去逛逛页看看吧" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.button = button;
}

#pragma mark - button点击时事件

- (IBAction)buttonClick:(UIButton *)sender
{
    [self.delegate MJRefreshButtonCick];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    //    self.label.frame = self.bounds;
    //
    //    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    //    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logo.mj_h * 0.5);
    
    self.label.frame = CGRectMake(0, 10, self.bounds.size.width, 20);
    self.button.frame = CGRectMake(0, 40,self.bounds.size.width , 20);
    
    //    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"赶紧上拉吖(开关是打酱油滴)";
//            [self.loading stopAnimating];
//            [self.s setOn:NO animated:YES];
            break;
        case MJRefreshStateRefreshing:
//            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中(开关是打酱油滴)";
//            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"木有数据了(开关是打酱油滴)";
//            [self.s setOn:NO animated:YES];
//            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

@end
