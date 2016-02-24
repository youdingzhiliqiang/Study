//
//  JsonChange.m
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "JsonChange.h"

@implementation JsonChange

+ (NSString *)fromObjectToString:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] >0 && error == nil) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    } else {
        return nil;
    }
}

+ (id)fromJsonDataToArrayOrDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return jsonObject;
}

+ (id)fromJsonStrToArrayOrDictionary:(NSString *)jsonStr
{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return jsonObject;
}

@end
