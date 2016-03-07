//
//  LQNextBlockVCL.h
//  Study
//
//  Created by 李强 on 16/3/4.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
typedef void (^sendStr)(NSString *str);
@interface LQNextBlockVCL : LQBaseVCL
@property (nonatomic,copy) sendStr sendStr;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end
