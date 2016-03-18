//
//  LQShowVCL.m
//  Study
//
//  Created by 李强 on 16/3/18.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQShowVCL.h"

@interface LQShowVCL ()

@end

@implementation LQShowVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    self.fromVCLLabel.text = [self.params objectForKey:@"fromVCL"];
    self.fromLineLabel.text = [self.params objectForKey:@"fromLine"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
