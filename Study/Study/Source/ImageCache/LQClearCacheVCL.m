//
//  LQClearCacheVCL.m
//  Study
//
//  Created by 李强 on 16/3/3.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQClearCacheVCL.h"
@interface LQClearCacheVCL ()

@end

@implementation LQClearCacheVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self obtainImageCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取图片缓存目录

- (NSString *)obtainImageCachePath
{
    //获取bubdleid
    NSString *boudleId = [[NSBundle mainBundle] bundleIdentifier];
    //获取af缓冲图片总目录
    NSString *component = [[FileManage getCacheDirectory] stringByAppendingPathComponent:boudleId];
    //在bundleid目下寻找com.alamofire.imagedownloader 文件夹路径
    NSString *imageDownStr = [component stringByAppendingPathComponent:@"com.alamofire.imagedownloader"];
    
    return imageDownStr;
}

#pragma mark - 获取图片缓存大小

- (void)obtainImageCache
{
    self.cacheLabel.text = [ImageCache getSizeOfImageCache];
    
    long long  fileSize = 0;
    // 图片缓存文件夹路径
    NSString *imageDownStr = [self obtainImageCachePath];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imageDownStr]) {
        self.cacheLabel.text = @"0";
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[fm subpathsAtPath:imageDownStr]];
    BOOL isDir = false;
    for (id fileStr  in [NSArray arrayWithArray:array]) {
        BOOL isDirExist = [fm fileExistsAtPath:[imageDownStr stringByAppendingPathComponent:fileStr] isDirectory:&isDir];
        if (isDir && isDirExist) {
            [array removeObject:fileStr];
        }
    }
    for (id fileStr in array) {
        fileSize += [self obtainFileSizeWithFileStr:[imageDownStr stringByAppendingPathComponent:fileStr]];
    }
    float fileFinalSize = fileSize/1024;
    if (fileFinalSize >= 1024) {
        self.cacheLabel.text = [NSString stringWithFormat:@"%.2fM",fileFinalSize/1024];
    } else if (fileFinalSize >0 && fileFinalSize < 1024) {
        self.cacheLabel.text = [NSString stringWithFormat:@"%.2fK",fileFinalSize];
    } else if (fileFinalSize == 0) {
        self.cacheLabel.text = @"0K";
    }
}

#pragma mark - 获取单个文件的大小

- (long long)obtainFileSizeWithFileStr:(NSString *)fileStr
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileStr]) {
        long long aaaa = [[fm attributesOfItemAtPath:fileStr error:nil] fileSize];
        return aaaa;
    }
    return 0;
}

#pragma mark- 清除缓存
- (IBAction)clearCacheButtonClick:(id)sender {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self clearImageCache];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self obtainImageCache];
            });
        });
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
    [alertController addAction:alertAction2];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -  清楚缓存

- (void)clearImageCache
{
    NSString *imageCachePath = [self obtainImageCachePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:imageCachePath]) {
        [fm removeItemAtPath:imageCachePath error:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
