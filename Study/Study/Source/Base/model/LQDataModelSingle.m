//
//  LQDataModelSingle.m
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQDataModelSingle.h"

static NSString *archiveFileName = @"DataModel.dat";
@implementation LQDataModelSingle

- (id)init
{
    self = [super init];
    if (self) {
        self.staticData = [[LQStaticData alloc] init];
    }
    return self;
}

+ (LQDataModelSingle *)sharedInstance
{
    static LQDataModelSingle *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil) {
            NSString *documentPath = [FileManage getCodingDirectory];
            NSString *archivePath = [documentPath stringByAppendingPathComponent:archiveFileName];
            sharedInstance = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
        }
        if (sharedInstance == nil) {
           sharedInstance = [[LQDataModelSingle alloc] init];
        }
    }
    return sharedInstance;
}

- (void)archive
{
    NSString *documentPath = [FileManage getCodingDirectory];
    NSString *archivePath = [documentPath stringByAppendingPathComponent:archiveFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.staticData = [aDecoder decodeObjectForKey:@"staticData"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.staticData forKey:@"staticData"];
}

@end
