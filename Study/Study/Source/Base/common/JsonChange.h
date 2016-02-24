//
//  JsonChange.h
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonChange : NSObject

//从object转换为nsstring类型
+ (NSString *)fromObjectToString:(id)theData;
//将jsondata转化为字典或者数组
+ (id)fromJsonDataToArrayOrDictionary:(NSData *)jsonData;
//将jsonstr转化为字典或者数组
+ (id)fromJsonStrToArrayOrDictionary:(NSString *)jsonStr;
@end
