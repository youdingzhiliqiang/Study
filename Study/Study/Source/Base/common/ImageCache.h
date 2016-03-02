//
//  ImageCache.h
//  Study
//
//  Created by 李强 on 16/2/29.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManage.h"
#import <UIKit/UIKit.h>
@interface ImageCache : NSObject
//创建并返回ImageCache目录
+ (NSString *)createImageCacheComponent:(NSString *)fileName;
//判断是否有imagecache目录,如果没有就创建
+ (BOOL)imageCacheIsExist;
//保存缓存图片
+ (BOOL)saveImageIntoImageCache:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType;
//读取图片
+ (NSData *)loadImageData:(NSString *)imageName;
//获取图片缓存大小
+ (NSString *)getSizeOfImageCache;
//删除图片缓存
+ (BOOL)deleteImageCache;
@end
