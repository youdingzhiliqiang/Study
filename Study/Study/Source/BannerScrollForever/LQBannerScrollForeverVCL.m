//
//  LQBannerScrollForeverVCL.m
//  Study
//
//  Created by 李强 on 16/3/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBannerScrollForeverVCL.h"
@interface LQBannerScrollForeverVCL ()
@property (nonatomic,strong) LQBannerScrollForeverView *bannerView;
@end

@implementation LQBannerScrollForeverVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addURLloadImageScrollviewForever];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加本地图片轮播图

- (void)addBannerScrollForever
{
    _bannerView = [[LQBannerScrollForeverView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_WIDTH)];
    NSArray *array = [NSArray arrayWithObjects:@"电影",@"篮球",@"跑步",@"游戏", nil];
    [_bannerView createScrollViewWithImageArray:array placeImage:nil delegate:self];
    [self.view addSubview:_bannerView];
}

#pragma mark - 添加网络加载图片轮播图

- (void)addURLloadImageScrollviewForever
{
    NSArray *array = [NSArray arrayWithObjects:@"http://static.udz.com/uploads/2016/2/15/38616518340252104.png.360.png",@"http://static.udz.com/uploads/2016/2/25/40256620075669765.png.360.png",@"http://static.udz.com/uploads/2016/2/25/40256100435741106.png.360.png",@"http://static.udz.com/uploads/2016/2/15/38622320286859098.png.360.png", nil];
    _bannerView = [[LQBannerScrollForeverView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_WIDTH)];
    [_bannerView createScrollViewWithURLImageArray:array placeImage:@"背景图" delegate:self];
    [self.view addSubview:_bannerView];
}

#pragma mark - 代理事件

- (void)ImageViewClick:(NSInteger)currentNum
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_bannerView != nil) {
        [_bannerView createTime];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_bannerView != nil) {
        [_bannerView removeTime];
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
