//
//  LQImageCacheVCL.m
//  Study
//
//  Created by 李强 on 16/2/29.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQImageCacheVCL.h"
#import "LQClearCacheVCL.h"
@interface LQImageCacheVCL ()

@end

@implementation LQImageCacheVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self.imageView setImageWithURL:[NSURL URLWithString:@"http://static.udz.com/statics/app/images/bannerlvbb2.jpg"] placeholderImage:[UIImage imageNamed:@"banner"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - push获取缓存页面

- (IBAction)deleteImageCache:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LQImageCacheVCL" bundle:nil];
    LQClearCacheVCL *cacheClear = [storyboard instantiateViewControllerWithIdentifier:@"LQClearCacheVCL"];
    [self.navigationController pushViewController:cacheClear animated:YES];
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
