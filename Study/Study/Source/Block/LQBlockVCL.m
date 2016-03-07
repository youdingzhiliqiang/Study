//
//  LQBlockVCL.m
//  Study
//
//  Created by 李强 on 16/3/4.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBlockVCL.h"
#import "LQNextBlockVCL.h"
@interface LQBlockVCL ()

@end

@implementation LQBlockVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self blockUse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - block的使用

- (void)blockUse
{
    void(^nslogBlock)() = ^()
    {
       
    };
    
    nslogBlock();
    nslogBlock(5);
    //用__block修饰的变量，在block中使用可以修改变量的值
    __block int blockTest = 5;
    
    int(^myBlock)(int) = ^(int num)
    {
        blockTest = 10;
        return blockTest * num;
    };
    myBlock(3);
}

#pragma mark - 下一步按钮的点击事件
- (IBAction)nextButtonClick:(id)sender {
    LQNextBlockVCL *nextBlock = [self.storyboard instantiateViewControllerWithIdentifier:@"LQNextBlockVCL"];
    nextBlock.sendStr = ^(NSString *textField) {
        [self changeLabelText:textField];
    };
    [self.navigationController pushViewController:nextBlock animated:YES];
}

#pragma mark- 改变label的文字

- (void)changeLabelText:(NSString *)textField
{
    self.label.text = textField;
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
