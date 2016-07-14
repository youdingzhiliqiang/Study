//
//  LQBlockVCL.h
//  Study
//
//  Created by 李强 on 16/3/4.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
#import "LQNextBlockVCL.h"
@interface LQBlockVCL : LQBaseVCL
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,assign) int intoBlockNum;

@property (nonatomic,strong) LQNextBlockVCL *nextBlock;

@end
