//
//  LQNextBlockVCL.m
//  Study
//
//  Created by 李强 on 16/3/4.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQNextBlockVCL.h"

@interface LQNextBlockVCL ()

@end

@implementation LQNextBlockVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender
{
    self.sendStr(self.textFiled.text);
    [self.navigationController popViewControllerAnimated:YES];
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
