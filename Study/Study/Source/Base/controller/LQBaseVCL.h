//
//  LQBaseVCL.h
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManage.h"
#import "common.h"
#import "LQDataModelSingle.h"
#import "MBProgressHUD.h"
@interface LQBaseVCL : UIViewController <MBProgressHUDDelegate>
//用于统一的页面传值
@property (nonatomic,strong) NSDictionary *params;
//导航添加返回按钮
- (void)addBackButton;

#pragma mark - 网络指示器
//初始化网络指示器
- (MBProgressHUD *)configChrysanthemum;
- (MBProgressHUD *)configChrysanthemumWithMessage:(NSString *)message;
//提醒视图
- (void)showMBProgressWithText:(NSString *)text;
- (void)showMBProgressForNetworkAnomalies;
- (void)hudWasHidden:(MBProgressHUD *)hud;

@end
