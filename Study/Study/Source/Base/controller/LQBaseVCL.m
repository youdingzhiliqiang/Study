//
//  LQBaseVCL.m
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
#import "common.h"
@interface LQBaseVCL ()

@end

@implementation LQBaseVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self addLeftSideReturn];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBackButton
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,14,10, 16)];
    imageView.image = [UIImage imageNamed:@"返回"];
    [buttonView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    [buttonView addGestureRecognizer:tap];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    self.navigationItem.leftBarButtonItem= item;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化网络指示器
- (MBProgressHUD *)configChrysanthemum
{
    MBProgressHUD *progress;
    if (self.navigationController.view != nil) {
        progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    } else {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    progress.labelText=@"正在加载";
    progress.minSize = CGSizeMake(100, 100);
    progress.delegate = self;
    //    progress.labelFont = FONT_TITLE_TEXT_FONT;
    return progress;
}
- (MBProgressHUD *)configChrysanthemumWithMessage:(NSString *)message
{
    MBProgressHUD *progress = [self configChrysanthemum];
    progress.labelText=message;
    return progress;
}

//提醒视图
- (void)showMBProgressWithText:(NSString *)text
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.delegate = self;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.yOffset = 30;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)showMBProgressForNetworkAnomalies
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate = self;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络连接异常，请重试！";
    hud.margin = 10.f;
    hud.yOffset = 30;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}
#pragma mark -  添加左滑返回功能
- (void)addLeftSideReturn
{
    if (self.navigationController.view != nil) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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
