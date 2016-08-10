//
//  LQHttpSessionManager.h
//  Study
//
//  Created by 李强 on 16/8/10.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LQHttpSessionManager : AFHTTPSessionManager

+ (LQHttpSessionManager *)sharedInstance;

@end
