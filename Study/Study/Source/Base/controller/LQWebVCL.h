//
//  LQWebVCL.h
//  Study
//
//  Created by 李强 on 16/4/14.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
#import "WebViewJavascriptBridge.h"
@interface LQWebVCL : LQBaseVCL <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@end
