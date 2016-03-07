//
//  LQTablePageVCL.m
//  Study
//
//  Created by 李强 on 16/3/7.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQTablePageVCL.h"
#import "LQFirstTCL.h"
#import "LQSecondTCL.h"
#import "LQThirdTCL.h"
#import "LQFourthTCL.h"
@interface LQTablePageVCL ()

@end

@implementation LQTablePageVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addChildViewcontroller];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加 childviewcontroller
- (void)addChildViewcontroller
{
    LQFirstTCL *first = [self.storyboard instantiateViewControllerWithIdentifier:@"LQFirstTCL"];
    [self addChildViewController:first];
    
    LQSecondTCL *second = [self.storyboard instantiateViewControllerWithIdentifier:@"LQSecondTCL"];
    [self addChildViewController:second];
    
    LQThirdTCL *third = [self.storyboard instantiateViewControllerWithIdentifier:@"LQThirdTCL"];
    [self addChildViewController:third];
    
    LQFourthTCL *fourth = [self.storyboard instantiateViewControllerWithIdentifier:@"LQFourthTCL"];
    [self addChildViewController:fourth];
    
    for (UIViewController *viewController in self.childViewControllers) {
        CGRect rect = viewController.view.frame;
        rect.origin = CGPointMake(0, 0);
        rect.size = self.contentView.frame.size;
        viewController.view.frame = rect;
    }
    [self.contentView addSubview:first.view];
    self.currentVCL = first;
}

#pragma mark 按钮点击切换view
- (IBAction)buttonClick:(UIButton *)sender {
    NSInteger i = [self.childViewControllers indexOfObject:self.currentVCL];
    if (i+1 == sender.tag) {
        return;
    }
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:sender.tag-1];
    [self transitionFromViewController:self.currentVCL toViewController:viewController duration:1 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.currentVCL = viewController;
        }
    }];
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
