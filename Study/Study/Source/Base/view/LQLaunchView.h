//
//  LQLaunchView.h
//  Study
//
//  Created by 李强 on 16/7/13.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
//关闭引导页回调block
typedef void (^LaunchViewCloseBlock)(void);

@interface LQLaunchView : UIWindow <UIScrollViewDelegate>

+ (LQLaunchView *)sharedInstance;

- (void)show;

@property (nonatomic,copy) LaunchViewCloseBlock launchViewCloseBlock;

@end
