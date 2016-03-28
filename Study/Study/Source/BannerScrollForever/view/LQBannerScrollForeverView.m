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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
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
        [self addSubview:_pageControl];
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
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*self.imageArray.count, self.frame.size.height);
    [self addSubview:self.pageControl];
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i,0, self.frame.size.width, self.frame.size.height)];
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
        
        [_scrollView addSubview:imageView];
    }
    //数据源多余3的情况下添加定时器
    if (self.imageArray.count >3) {
        CGPoint point = _scrollView.contentOffset;
        point.x = self.frame.size.width;
        _scrollView.contentOffset = point;
        [self createTime];
    }
    self.delegate = delegate;
}

#pragma mark - 倒计时自动滑动

- (void)timeChange
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + self.frame.size.width, 0) animated:YES];
    [self timeControlScrollView:_scrollView];
}


#pragma mark scrollview的代理函数

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTime];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self createTime];
    if (_scrollView.contentOffset.x == 0 || _scrollView.contentOffset.x == self.frame.size.width *(self.imageArray.count - 2)) {
        _pageControl.currentPage = _pageControl.numberOfPages;
    } else if (_scrollView.contentOffset.x == self.frame.size.width || _scrollView.contentOffset.x == self.frame.size.width *(self.imageArray.count - 1)) {
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = _scrollView.contentOffset.x/self.frame.size.width - 1;
    }
    
    
    if (scrollView.contentOffset.x == self.frame.size.width * (self.imageArray.count - 1)) {
        CGPoint point = _scrollView.contentOffset;
        point.x = self.frame.size.width;
        _scrollView.contentOffset = point;
    } else if (scrollView.contentOffset.x == 0) {
        CGPoint point = _scrollView.contentOffset;
        point.x = self.frame.size.width * (self.imageArray.count - 2);
        _scrollView.contentOffset = point;
    }
    
}

#pragma mark - 倒计时控制滑动

- (void)timeControlScrollView:(UIScrollView *)scrollView
{
    NSInteger position = scrollView.contentOffset.x / self.frame.size.width;
    if (position >= self.imageArray.count - 2) {
        position = position + 2 - self.imageArray.count;
    }
    _pageControl.currentPage = position;
    
    if (scrollView.contentOffset.x == self.frame.size.width * (self.imageArray.count - 1)) {
        CGPoint point = _scrollView.contentOffset;
        point.x = self.frame.size.width;
        _scrollView.contentOffset = point;
    } else if (scrollView.contentOffset.x == 0) {
        CGPoint point = _scrollView.contentOffset;
        point.x = self.frame.size.width * (self.imageArray.count - 2);
        _scrollView.contentOffset = point;
    }
}

#pragma mark - imageView点击事件

- (void)imageViewTapClick:(UITapGestureRecognizer *)tap
{
    [self.delegate ImageViewClick:tap.view.tag - viewTag - 1];
}

#pragma mark - 创建定时器

- (void)createTime
{
    if (self.timer == nil && self.imageArray.count >3) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERMINAL target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark- 移除定时器
- (void)removeTime
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
