//
//  ImageCache.m
//  Study
//
//  Created by 李强 on 16/2/29.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "ImageCache.h"
static NSString *fileName = @"ImageCache";
@implementation ImageCache
#pragma mark - 创建imagecache 目录
+ (NSString *)createImageCacheComponent:(NSString *)fileName
{
    NSString *cachePath = [FileManage getCacheDirectory];
    return [cachePath stringByAppendingPathComponent:fileName];
}
#pragma mark - 判断是否有imagecache目录,如果没有就创建
+ (BOOL)imageCacheIsExist
{
    NSString *imageCache = [self createImageCacheComponent:fileName];
    BOOL isDir = NO;
    BOOL existd = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    existd = [fm fileExistsAtPath:[self createImageCacheComponent:fileName] isDirectory:&isDir];
    BOOL isCreated = NO;
    if (existd == NO || isDir == NO) {
        isCreated = [fm createDirectoryAtPath:imageCache withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existd == YES) {
        isCreated = YES;
    }
    return isCreated;
}

#pragma mark - 保存图片缓存

+ (BOOL)saveImageIntoImageCache:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType
{
    NSString *imageCacheStr = [self createImageCacheComponent:fileName];
    BOOL isDir = NO;
    BOOL existd = NO;
    BOOL isSaved = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    existd = [fm fileExistsAtPath:imageCacheStr isDirectory:&isDir];
    if (existd == YES && isDir == YES) {
        if ([[imageType lowercaseString] isEqualToString:@"png"]) {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[imageCacheStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]] atomically:YES];
        } else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageCacheStr lowercaseString] isEqualToString:@"jpeg"]) {
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[imageCacheStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]] atomically:YES];
        } else {
            
        }
        
    }
    if (isSaved ) {
        
    }
    return isSaved;
}

#pragma mark - 读取图片

+ (NSData *)loadImageData:(NSString *)imageName
{
    
    NSString *imageCacheStr = [self createImageCacheComponent:fileName];
    BOOL isExistd = NO;
    BOOL isDir = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    isExistd = [fm fileExistsAtPath:imageCacheStr isDirectory:&isDir];
    if (isDir == YES && isExistd == YES) {
        NSString *imageNameStr = [imageCacheStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
        BOOL isFileExistd = NO;
        isFileExistd = [fm fileExistsAtPath:imageNameStr];
        NSString *realImageName;
        if (isFileExistd == YES) {
            realImageName = imageNameStr;
        } else {
            realImageName = [imageNameStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",imageName]];
        }
        NSData *imageData = [NSData dataWithContentsOfFile:realImageName];
        return imageData;
    }
    return nil;
}

#pragma mark - 获取缓存大小
+ (NSString *)getSizeOfImageCache
{
    NSString *imageCachStr = [self createImageCacheComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *imageArray = [[NSArray alloc] initWithArray:[fm contentsOfDirectoryAtPath:imageCachStr error:&error]];
    long long fileSize = 0;
    for (NSString *str in imageArray) {
        NSString *imageStr = [imageCachStr stringByAppendingPathComponent:str];
        NSDictionary *imageDic = [fm attributesOfItemAtPath:imageStr error:&error];
        fileSize = fileSize + [imageDic fileSize];
    }
    
    float imageCacheSize = fileSize /1024.0;
    NSString *DirSize = nil;
    if (imageCacheSize >= 1024.0) {
        imageCacheSize = imageCacheSize / 1024;
        DirSize = [NSString stringWithFormat:@"%.2fM",imageCacheSize];
    } else {
        if (imageCacheSize == 0) {
            DirSize = @"0";
        } else {
            DirSize = [NSString stringWithFormat:@"%.2fK",imageCacheSize];
        }
    }
    return DirSize;
}

#pragma mark - 删除缓存

+ (BOOL)deleteImageCache
{
    NSString *imageCacheStr = [self createImageCacheComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL isDelete = NO;
    isDelete = [fm removeItemAtPath:imageCacheStr error:&error];
    return isDelete;
}

@end
