//
//  LQStaticData.m
//  Study
//
//  Created by 李强 on 16/2/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQStaticData.h"

@implementation LQStaticData

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.textfieldShow forKey:@"textfieldShow"];
    [aCoder encodeObject:self.isFirstLaunch forKey:@"isFirstLaunch"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.textfieldShow = [aDecoder decodeObjectForKey:@"textfieldShow"];
    self.isFirstLaunch = [aDecoder decodeObjectForKey:@"isFirstLaunch"];
    return self;
}

@end
