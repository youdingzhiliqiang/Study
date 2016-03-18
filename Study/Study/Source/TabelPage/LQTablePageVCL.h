//
//  LQTablePageVCL.h
//  Study
//
//  Created by 李强 on 16/3/7.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
#import "LQFirstTCL.h"
#import "LQSecondTCL.h"
#import "LQThirdTCL.h"
#import "LQFourthTCL.h"
@interface LQTablePageVCL : LQBaseVCL <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic,strong) NSMutableArray *viewControlerArray;
@property (nonatomic,strong) LQFirstTCL *firstVCL;
@property (nonatomic,strong) LQSecondTCL *secondVCL;
@property (nonatomic,strong) LQThirdTCL *thirdVCL;
@property (nonatomic,strong) LQFourthTCL *fourthVCL;
@end
