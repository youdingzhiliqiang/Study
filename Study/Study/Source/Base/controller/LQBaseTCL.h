//
//  LQBaseTCL.h
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQBaseTCL : UITableViewController
//用于统一的页面传值
@property (nonatomic,strong) NSDictionary *params;
//数据源
@property (nonatomic,strong) NSMutableArray *dataArray;


//导航添加返回按钮
- (void)addBackButton;
@end
