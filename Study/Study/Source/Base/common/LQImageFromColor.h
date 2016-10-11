//
//  LQImageFromColor.h
//  Study
//
//  Created by 李强 on 16/10/11.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LQImageFromColor : NSObject

#pragma mark - 将颜色转变为图片
+ (UIImage *)getImageFromColor:(UIColor *)color;

@end
