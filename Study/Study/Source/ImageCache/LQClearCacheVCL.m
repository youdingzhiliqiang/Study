//
//  LQClearCacheVCL.m
//  Study
//
//  Created by 李强 on 16/3/3.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQClearCacheVCL.h"

@interface LQClearCacheVCL ()

@end

@implementation LQClearCacheVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self obtainImageCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取图片缓存大小

- (void)obtainImageCache
{
    //self.cacheLabel.text = [ImageCache getSizeOfImageCache];
}

#pragma mark- 清除缓存
- (IBAction)clearCacheButtonClick:(id)sender {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [ImageCache deleteImageCache];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cacheLabel.text = [ImageCache getSizeOfImageCache];
            });
        });
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
    [alertController addAction:alertAction2];
    [self presentViewController:alertController animated:YES completion:nil];
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
