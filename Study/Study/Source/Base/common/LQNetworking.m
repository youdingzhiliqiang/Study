//
//  LQNetworking.m
//  Study
//
//  Created by 李强 on 16/8/9.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQNetworking.h"
#import <AFNetworking.h>
#import "LQHttpSessionManager.h"

@implementation LQNetworking

- (NSURLSessionDataTask *_Nullable)post:(nonnull NSString *)urlString
                             parameters:(nullable id)parameters
                               progress:(nonnull RequestProgress)progress
                                success:(nonnull RequestSuccess)success
                                failure:(nonnull RequestFailure)failuer
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    NSURLSessionDataTask *task = [[LQHttpSessionManager sharedInstance] POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failuer) {
            failuer(task,error);
        }
    }];
    
    return task;
}

//+ (AFHTTPSessionManager *)sharedInstance
//{
//    static AFHTTPSessionManager *manager;
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        manager = [AFHTTPSessionManager manager];
//    });
//    return manager;
//}


@end
