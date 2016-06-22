//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYHeader.h"
#import "Common.h"
@interface MJDIYHeader()
@property (nonatomic,weak) UIImage *normalImage;
@property (nonatomic,weak) UIImage *scaleImage;
@end

@implementation MJDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下拉刷新"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
    
    //图片设置
    self.normalImage = [UIImage imageNamed:@"arrow"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.normalImage];
    [self addSubview:imageView];
    self.imageView = imageView;
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    /* Make the animation 5 seconds long */
    [UIView setAnimationDuration:0.2f];
    //顺时针旋转90度
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, (M_PI));
    /* Commit the animation */
    [UIView commitAnimations];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    //    self.label.frame = self.bounds;
    //
    //    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    //    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
    //
    //    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
    
    self.logo.bounds = CGRectMake(0, 0, 190,16);
    self.logo.center = CGPointMake(self.mj_w * 0.5,-25);
    
    self.label.frame = CGRectMake(0, 0,self.bounds.size.width, 16);
    self.label.center = CGPointMake(self.mj_w * 0.5, 25);
    
    self.loading.center = CGPointMake( self.mj_w *0.5 - 85, 25);
    
    
    self.imageView.frame = CGRectMake(0, 0, 15, 40);
    self.imageView.center = CGPointMake( self.mj_w *0.5 - 85, 25);
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
            [self.loading stopAnimating];
            //            [self.s setOn:NO animated:YES];
            self.label.text = @"下拉可以刷新";
            [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
            /* Make the animation 5 seconds long */
            [UIView setAnimationDuration:0.2f];
            //顺时针旋转90度
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, (M_PI));
            /* Commit the animation */
            [UIView commitAnimations];
            self.imageView.hidden = NO;
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            //            [self.s setOn:YES animated:YES];
            self.label.text = @"松开立即刷新";
            self.imageView.hidden = NO;
            [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
            /* Make the animation 5 seconds long */
            [UIView setAnimationDuration:0.2f];
            //顺时针旋转90度
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, (-M_PI * 3));
            /* Commit the animation */
            [UIView commitAnimations];
            break;
        case MJRefreshStateRefreshing:
            //            [self.s setOn:YES animated:YES];
            self.imageView.hidden = YES;
            self.label.text = @"正在刷新数据中...";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
