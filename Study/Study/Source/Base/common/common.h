//
//  common.h
//  Study
//
//  Created by 李强 on 16/2/22.
//  Copyright © 2016年 李强. All rights reserved.
//

#ifndef common_h
#define common_h

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)

#pragma mark - 屏幕高度和宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#pragma mark - 颜色
//app背景色
#define COLOR_BACKGROUND [UIColor colorWithRed:246/255.0 green:246/255.0 blue:248/255.0 alpha:1]
//红粉色
#define COLOR_PINK [UIColor colorWithRed:238/255.0 green:84/255.0 blue:84/255.0 alpha:1]

#pragma mark - 字体

#define FONT_12 [UIFont systemFontOfSize:12]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_16 [UIFont systemFontOfSize:16]
#define font_18 [UIFont systemFontOfSize:18]


#endif /* common_h */
