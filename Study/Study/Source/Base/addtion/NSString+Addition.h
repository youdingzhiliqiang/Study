//
//  NSString+Addition.h
//  Study
//
//  Created by 李强 on 16/3/1.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString_Addition : NSString
//md5 32位 加密 （小写）
+ (NSString *)md5ToLowerCase:(NSString *)str;
//md5 16位加密 （大写） (16位其实是截取32位中间的16位)
+ (NSString *)md5ToBiggerCase:(NSString *)str;

@end
