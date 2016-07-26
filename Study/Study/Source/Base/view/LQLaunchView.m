//
//  LQLaunchView.m
//  Study
//
//  Created by 李强 on 16/7/13.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQLaunchView.h"
#import "common.h"
@interface LQLaunchView ()

@end

@implementation LQLaunchView
{
    UIScrollView *_scrollView;
    NSMutableArray *_imageArray;
}
/**
 *  创建单例
 *
 *  @return 返回单例对象
 */
+ (LQLaunchView *)sharedInstance
{
    static LQLaunchView *launchView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        launchView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return launchView;
}

/**
 *  控制引导图的展现
 */
- (void)show
{
    self.windowLevel = UIWindowLevelStatusBar + 1;
    [self makeKeyWindow];
    self.hidden = NO;
}

/**
 *  创建引导图
 *
 *  @param frame
 *
 *  @return 引导图view
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    //初始化图片数组
    [self initImageArray];
    
    //初始化scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageArray.count, SCREEN_HEIGHT);
    [self addSubview:_scrollView];
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
        if (i == _imageArray.count -1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
    return self;
}

/**
 *  初始化图片数组
 */
- (void)initImageArray
{
    
    _imageArray = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0; i < 4; i++) {
        if (IS_IPHONE_4) {
            [_imageArray addObject:[NSString stringWithFormat:@"iPhone4欢迎页%d",i+1]];
        }else if (IS_IPHONE_5) {
            [_imageArray addObject:[NSString stringWithFormat:@"iPhone5欢迎页%d",i+1]];
        }else if (IS_IPHONE_6) {
            [_imageArray addObject:[NSString stringWithFormat:@"iPhone6欢迎页%d",i+1]];
        }else if (IS_IPHONE_6_PLUS) {
            [_imageArray addObject:[NSString stringWithFormat:@"iPhone6p欢迎页%d",i+1]];
        }
    }
}

/**
 *  隐藏window
 */
- (void)hide
{
    [self resignKeyWindow];
    self.hidden = YES;
    
    self.launchViewCloseBlock();
}

/**
 *
 */
- (void)dealloc
{
    _scrollView.delegate = nil;
}


@end
