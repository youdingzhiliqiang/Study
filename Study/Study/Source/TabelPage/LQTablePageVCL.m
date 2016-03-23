//
//  LQTablePageVCL.m
//  Study
//
//  Created by 李强 on 16/3/7.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQTablePageVCL.h"
@interface LQTablePageVCL ()

@end

@implementation LQTablePageVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setScrollview];
    [self addBackButton];
    [self addChildViewcontroller];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scrollview的设置和创建

- (void)setScrollview
{
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*4, self.scrollview.frame.size.height);
}


#pragma mark - 添加 VIEW
- (void)addChildViewcontroller
{
    self.viewControlerArray = [[NSMutableArray alloc] init];
    self.firstVCL = [self.storyboard instantiateViewControllerWithIdentifier:@"LQFirstTCL"];
    [self.viewControlerArray addObject:self.firstVCL];
    self.secondVCL = [self.storyboard instantiateViewControllerWithIdentifier:@"LQSecondTCL"];
    [self.viewControlerArray addObject:self.secondVCL];
    self.thirdVCL = [self.storyboard instantiateViewControllerWithIdentifier:@"LQThirdTCL"];
    [self.viewControlerArray addObject:self.thirdVCL];
    self.fourthVCL = [self.storyboard instantiateViewControllerWithIdentifier:@"LQFourthTCL"];
    [self.viewControlerArray addObject:self.fourthVCL];
    
    for (UITableViewController *viewController in self.viewControlerArray) {
        NSInteger i = [self.viewControlerArray indexOfObject:viewController];
        CGRect rect = viewController.view.frame;
        rect.origin = CGPointMake(SCREEN_WIDTH*i, 0);
        rect.size = self.scrollview.frame.size;
        viewController.view.frame = rect;
        [self.scrollview addSubview:viewController.view];
    }
    
    [self addChildViewController:self.firstVCL];
    [self addChildViewController:self.secondVCL];
    [self addChildViewController:self.thirdVCL];
    [self addChildViewController:self.fourthVCL];
}

#pragma mark - scrollView代理函数

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger viewInt = self.scrollview.contentOffset.x/SCREEN_WIDTH;
    switch (viewInt) {
        case 0:
            if (self.firstVCL.isFirstLoadData == NO) {
               [self.firstVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 1:
            if (self.secondVCL.isFirstLoadData == NO) {
                [self.secondVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 2:
            if (self.thirdVCL.isFirstLoadData == NO) {
                [self.thirdVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 3:
            if (self.fourthVCL.isFirstLoadData == NO) {
                [self.fourthVCL.tableView.mj_header beginRefreshing];
            }
            break;
        default:
            break;
    }
}

#pragma mark 按钮点击切换view
- (IBAction)buttonClick:(UIButton *)sender {
    [self.scrollview setContentOffset:CGPointMake(SCREEN_WIDTH*(sender.tag-1), 0)];
    switch (sender.tag-1) {
        case 0:
            if (self.firstVCL.isFirstLoadData == NO) {
                [self.firstVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 1:
            if (self.secondVCL.isFirstLoadData == NO) {
                [self.secondVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 2:
            if (self.thirdVCL.isFirstLoadData == NO) {
                [self.thirdVCL.tableView.mj_header beginRefreshing];
            }
            break;
        case 3:
            if (self.fourthVCL.isFirstLoadData == NO) {
                [self.fourthVCL.tableView.mj_header beginRefreshing];
            }
            break;
        default:
            break;
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
