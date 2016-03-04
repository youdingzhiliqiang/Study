//
//  LQNextBlockVCL.h
//  Study
//
//  Created by 李强 on 16/3/4.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"

@interface LQNextBlockVCL : LQBaseVCL
@property (nonatomic,copy) void(^sendStr)(NSString *str);
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end
