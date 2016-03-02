//
//  LQImageCacheVCL.m
//  Study
//
//  Created by 李强 on 16/2/29.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQImageCacheVCL.h"

@interface LQImageCacheVCL ()

@end

@implementation LQImageCacheVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self.imageView setImageWithURL:[NSURL URLWithString:@"http://static.udz.com/statics/app/images/bannerlvbb2.jpg"] placeholderImage:[UIImage imageNamed:@"banner"]];
    [self obtainImageCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取图片缓存大小

- (void)obtainImageCache
{
    self.imageCacheLabel.text = [ImageCache getSizeOfImageCache];
}

#pragma mark - 删除图片缓存

- (IBAction)deleteImageCache:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageCacheSize = [ImageCache getSizeOfImageCache];
//            MBProgressHUD *hud;
//            if ([imageCacheSize length] > 0) {
//               hud = [self configChrysanthemum];
//            }
            [ImageCache deleteImageCache];
            dispatch_async(dispatch_get_main_queue(), ^{
               self.imageCacheLabel.text = [ImageCache getSizeOfImageCache];
//                if (hud != nil) {
//                    [self hudWasHidden:hud];
//                }
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
