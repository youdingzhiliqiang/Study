//
//  NSString+Addition.m
//  Study
//
//  Created by 李强 on 16/3/1.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString_Addition

+ (NSString *)md5ToLowerCase:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}
//http://static.udz.com/uploads/2016/2/9/38898866212730296.png.360.png
//b1831549ed6cec187e62427e30a412a4
+ (NSString *)md5ToBiggerCase:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *mdStr = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                              result[0], result[1], result[2], result[3],
                              result[4], result[5], result[6], result[7],
                              result[8], result[9], result[10], result[11],
                              result[12], result[13], result[14], result[15]
                              ];
    NSString *finalStr = [mdStr substringWithRange:NSMakeRange(8, 16)];
    return finalStr;
}
@end
