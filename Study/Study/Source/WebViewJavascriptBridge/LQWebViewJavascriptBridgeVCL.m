//
//  LQWebViewJavascriptBridgeVCL.m
//  Study
//
//  Created by 李强 on 16/4/14.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQWebViewJavascriptBridgeVCL.h"

@interface LQWebViewJavascriptBridgeVCL ()

@end

@implementation LQWebViewJavascriptBridgeVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadHtml];
    [self createSegmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载html页面

- (void)loadHtml
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *htmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [NSURL URLWithString:htmlStr];
    [self.webView loadHTMLString:htmlStr baseURL:url];
}

#pragma mark - 创建segmentControl
- (void)createSegmentControl
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    NSDictionary *textSelectedDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,FONT_14,NSFontAttributeName, nil];
    NSDictionary *textNormalDictionary = [NSDictionary dictionaryWithObjectsAndKeys:COLOR_PINK,NSForegroundColorAttributeName,FONT_14,NSFontAttributeName, nil];
    [segmentedControl setTitleTextAttributes:textSelectedDictionary forState:UIControlStateSelected];
    [segmentedControl setTitleTextAttributes:textNormalDictionary forState:UIControlStateNormal];
    segmentedControl.tintColor = COLOR_PINK;
    [segmentedControl insertSegmentWithTitle:@"OC TO JS" atIndex:0 animated:NO];
    [segmentedControl insertSegmentWithTitle:@"JS TO OC" atIndex:1 animated:NO];
    [segmentedControl addTarget:self action:@selector(segmentPress:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

#pragma mark - segmentcontrol 的点击事件

- (void)segmentPress:(UISegmentedControl *)segmented
{
    if (segmented.selectedSegmentIndex == 0) {
//        [self.bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    } else {
//         [self.bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
        [self.bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" } responseCallback:^(id responseData) {
            NSDictionary *dic = responseData;
           NSLog(@"testJavascriptHandler responded: %@",responseData);
        }];
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
