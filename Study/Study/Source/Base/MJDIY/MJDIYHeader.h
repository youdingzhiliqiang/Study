//
//  MJDIYHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefresh.h"

@interface MJDIYHeader : MJRefreshHeader
//刷新提示文字
@property (weak, nonatomic) UILabel *label;
//刷新图标显示
@property (weak, nonatomic) UIImageView *logo;
//菊花
@property (weak, nonatomic) UIActivityIndicatorView *loading;
//箭头
@property (weak, nonatomic) UIImageView *imageView;
@end
