//
//  LQDataModelSingle.h
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManage.h"
#import "LQStaticData.h"
@interface LQDataModelSingle : NSObject<NSCoding>
@property (nonatomic,strong) LQStaticData *staticData;

+ (LQDataModelSingle *)sharedInstance;
- (void)archive;

@end
