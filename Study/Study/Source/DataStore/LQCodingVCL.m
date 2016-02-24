//
//  LQCodingVCL.m
//  Study
//
//  Created by 李强 on 16/2/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQCodingVCL.h"

@interface LQCodingVCL ()

@end

@implementation LQCodingVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self setTextfield];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置textfield

- (void)setTextfield
{
    LQDataModelSingle *dm = [LQDataModelSingle sharedInstance];
    self.textfield.placeholder = dm.staticData.textfieldShow;
    self.storeButton.layer.cornerRadius = 30;
}

- (IBAction)storeButtonClick:(id)sender {
    LQDataModelSingle *dm = [LQDataModelSingle sharedInstance];
    if ([self.textfield.text length] >0) {
        dm.staticData.textfieldShow = self.textfield.text;
        [dm archive];
        [self showMBProgressWithText:@"保存成功"];
    } else {
        [self showMBProgressWithText:@"请输入需要保存的信息"];
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
