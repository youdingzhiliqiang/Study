//
//  FileManage.h
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonChange.h"
@interface FileManage : NSObject
/*   iPhone app 沙箱模型 有四个文件夹，
 1.Documents 目录 讲程序数据文件写在这个文件夹下
 2.AppName.app 目录 存放程序本身，一般不进行修改
 3.Library 目录 分为 caches目录  和 preferences目录
  Preferences 目录：包含应用程序的偏好设置文件。不能直接创建偏好设置文件，而是使用NSUserDefaults 类取得和设置应用程序的偏好
  Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
 4.tmp 目录  这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。 */
//获取家目录路径的函数
+ (NSString *)getHomeDirectory;
//获取Documents目录
+ (NSString *)getDocumentsDirectory;
//获取cache目录
+ (NSString *)getCacheDirectory;
//获取tmp目录
+ (NSString *)getTmpDirectory;
//获取省市区文件
+ (NSArray *)obtainDistrict;
//获取coding目录
+ (NSString *)getCodingDirectory;
@end
