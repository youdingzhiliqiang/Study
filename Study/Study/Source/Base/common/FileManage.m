//
//  FileManage.m
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "FileManage.h"

static NSString *documentNextComponent = @"data";
static NSString *projectName = @"Study";

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

+ (NSString *)getCodingDirectory
{
    NSString *documentPath = [self getDocumentsDirectory];
    NSString *dataPath = [documentPath stringByAppendingPathComponent:documentNextComponent];
    NSString *projectNmaePath = [dataPath stringByAppendingPathComponent:projectName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = YES;
    if (![fileManager fileExistsAtPath:projectNmaePath isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:projectNmaePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return projectNmaePath;
}

@end
