//
//  LQBannerScrollForeverView.m
//  Study
//
//  Created by 李强 on 16/3/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBannerScrollForeverView.h"
#import "common.h"
#import "UIImageView+AFNetworking.h"
enum {
    viewTag = 1111,
    imageType = 2222,
    imageURLType = 3333,
};

#define TIME_INTERMINAL 2.0

@interface LQBannerScrollForeverView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation LQBannerScrollForeverView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.directionalLockEnabled = YES;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if ((!_pageControl)) {
        _pageControl = [[UIPageControl alloc] init];
        CGSize size = [_pageControl sizeForNumberOfPages:5];
        _pageControl.frame = CGRectMake(self.frame.size.width - 12 - size.width,self.frame.size.height - 12 - size.height, size.width, size.height);
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPageIndicatorTintColor = COLOR_PINK;
        _pageControl.numberOfPages = self.imageArray.count - 2;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}


#pragma mark - 创建的为本地image的banner

- (void)createScrollViewWithImageArray:(NSArray *)imageArray placeImage:(NSString *)placeImage delegate:(id<ImageViewDelegate>)delegate
{
    
    [self createScrollViewWithImageType:imageType ImageArray:imageArray placeImage:placeImage delegate:delegate];
}

#pragma mark - 创建的为网络加载image的banner
- (void)createScrollViewWithURLImageArray:(NSArray *)urlImageArray placeImage:(NSString *)placeImage delegate:(id<ImageViewDelegate>)delegate
{
    
    [self createScrollViewWithImageType:imageURLType ImageArray:urlImageArray placeImage:placeImage delegate:delegate];
}

#pragma mark - 创建滚动视图

- (void)createScrollViewWithImageType:(int)imageArrayType ImageArray:(NSArray *)imageArray placeImage:(NSString *)placeImage delegate:(id<ImageViewDelegate>)delegate
{
    if (imageArray.count > 1) {
        [self.imageArray addObject:[imageArray lastObject]];
        for (NSString *str in imageArray) {
            [self.imageArray addObject:str];
        }
        [self.imageArray addObject:[imageArray firstObject]];
    } else {
        [self.imageArray addObject:[imageArray firstObject]];
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.imageArray.count, self.frame.size.height);
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i,0, SCREEN_WIDTH, self.frame.size.height)];
        if (imageArrayType == imageType) {
            imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:i]];
        } else if (imageArrayType == imageURLType) {
            [imageView setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:placeImage]];
        }
        imageView.userInteractionEnabled = YES;
        
        if (self.imageArray.count >=3 ) {
            if ( i == 0) {
                imageView.tag = viewTag + self.imageArray.count - 1;
            } else if (i == self.imageArray.count - 1) {
                imageView.tag = 1 + viewTag;
            } else {
                imageView.tag = viewTag + i;
            }
        } else {
            imageView.tag = viewTag + i;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapClick:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
    }
    //数据源多余3的情况下添加定时器
    if (self.imageArray.count >3) {
        
        CGPoint point = self.scrollView.contentOffset;
        point.x = SCREEN_WIDTH;
        self.scrollView.contentOffset = point;
        
        [self addSubview:self.pageControl];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERMINAL target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    self.delegate = delegate;
}

#pragma mark - 倒计时自动滑动

- (void)timeChange
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + SCREEN_WIDTH, 0) animated:YES];
    [self timeControlScrollView:self.scrollView];
}


#pragma mark scrollview的代理函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERMINAL target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    if (self.scrollView.contentOffset.x == 0 || self.scrollView.contentOffset.x == SCREEN_WIDTH *(self.imageArray.count - 2)) {
        self.pageControl.currentPage = self.pageControl.numberOfPages;
    } else if (self.scrollView.contentOffset.x == SCREEN_WIDTH || self.scrollView.contentOffset.x == SCREEN_WIDTH *(self.imageArray.count - 1)) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = self.scrollView.contentOffset.x/SCREEN_WIDTH - 1;
    }
    
    if (scrollView.contentOffset.x == SCREEN_WIDTH * (self.imageArray.count - 1)) {
        CGPoint point = self.scrollView.contentOffset;
        point.x = SCREEN_WIDTH;
        self.scrollView.contentOffset = point;
    } else if (scrollView.contentOffset.x == 0) {
        CGPoint point = self.scrollView.contentOffset;
        point.x = SCREEN_WIDTH * (self.imageArray.count - 2);
        self.scrollView.contentOffset = point;
    }
    
}

#pragma mark - 倒计时控制滑动

- (void)timeControlScrollView:(UIScrollView *)scrollView
{
    NSInteger position = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (position >= self.imageArray.count - 2) {
        position = position + 2 - self.imageArray.count;
    }
    self.pageControl.currentPage = position;
    
    if (scrollView.contentOffset.x == SCREEN_WIDTH * (self.imageArray.count - 1)) {
        CGPoint point = self.scrollView.contentOffset;
        point.x = SCREEN_WIDTH;
        self.scrollView.contentOffset = point;
    } else if (scrollView.contentOffset.x == 0) {
        CGPoint point = self.scrollView.contentOffset;
        point.x = SCREEN_WIDTH * (self.imageArray.count - 2);
        self.scrollView.contentOffset = point;
    }
}

#pragma mark - imageView点击事件

- (void)imageViewTapClick:(UITapGestureRecognizer *)tap
{
    [self.delegate ImageViewClick:tap.view.tag - viewTag - 1];
}

@end
