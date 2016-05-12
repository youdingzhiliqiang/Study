//
//  LQWebVCL.m
//  Study
//
//  Created by 李强 on 16/4/14.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQWebVCL.h"

@interface LQWebVCL ()

@end

@implementation LQWebVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addSubviewWebView];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"123");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建webview

- (void)addSubviewWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT - 64)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
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
