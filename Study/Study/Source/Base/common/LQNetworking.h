//
//  LQNetworking.h
//  Study
//
//  Created by 李强 on 16/8/9.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSURLSessionDataTask;

typedef void(^RequestProgress)(NSProgress *_Nonnull uploadProgress);
typedef void(^RequestSuccess)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject);
typedef void(^RequestFailure)(NSURLSessionDataTask *_Nonnull task, NSError * _Nonnull error);

@interface LQNetworking : NSObject

- (NSURLSessionDataTask *_Nullable)post:(nonnull NSString *)urlString
                             parameters:(nullable id)parameters
                               progress:(nonnull RequestProgress)progress
                                success:(nonnull RequestSuccess)success
                                failure:(nonnull RequestFailure)failuer;

@end
