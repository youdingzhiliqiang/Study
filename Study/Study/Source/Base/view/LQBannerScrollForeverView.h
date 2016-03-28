//
//  LQBannerScrollForeverView.h
//  Study
//
//  Created by 李强 on 16/3/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明一个协议
@protocol ImageViewDelegate;

@interface LQBannerScrollForeverView : UIView

@property (nonatomic,assign) id <ImageViewDelegate> delegate;

- (void)createScrollViewWithImageArray:(NSArray *)imageArray placeImage:(NSString *)placeImage delegate:(id<ImageViewDelegate>)delegate;
- (void)createScrollViewWithURLImageArray:(NSArray *)urlImageArray placeImage:(NSString *)placeImage delegate:(id<ImageViewDelegate>)delegate;
- (void)createTime;
- (void)removeTime;
@end

#pragma mark - 协议方法
@protocol ImageViewDelegate <NSObject>

- (void)ImageViewClick:(NSInteger)currentNum;

@end