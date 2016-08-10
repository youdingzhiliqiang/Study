//
//  LQHttpSessionManager.m
//  Study
//
//  Created by 李强 on 16/8/10.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQHttpSessionManager.h"

@implementation LQHttpSessionManager

+ (LQHttpSessionManager *)sharedInstance
{
    static LQHttpSessionManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [LQHttpSessionManager manager];
    });
    return manager;
}

@end
