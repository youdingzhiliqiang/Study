//
//  FileManage.m
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "FileManage.h"

@implementation FileManage

+ (NSString *)getHomeDirectory
{
    return NSHomeDirectory();
}

+ (NSString *)getDocumentsDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentStr = [paths objectAtIndex:0];
    return documentStr;
}

+ (NSString *)getCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheStr = [paths objectAtIndex:0];
    return cacheStr;
}

+ (NSString *)getTmpDirectory
{
    return NSTemporaryDirectory();
}

+ (NSArray *)obtainDistrict
{
    NSString *districtStr = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [districtStr stringByAppendingPathComponent:@"address.json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *districtArray = [JsonChange fromJsonDataToArrayOrDictionary:data];
    return districtArray;
}

@end
