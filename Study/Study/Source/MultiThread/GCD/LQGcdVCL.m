//
//  LQGcdVCL.m
//  Study
//
//  Created by 李强 on 16/3/3.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQGcdVCL.h"

@interface LQGcdVCL ()

@end

@implementation LQGcdVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- 主线程异步执行
- (IBAction)mainButtonClick:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"异步第一线程：%d",i);
            self.firstLabel.text = [NSString stringWithFormat:@"%d",i];
            [NSThread sleepForTimeInterval:1];
            
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"异步第二线程：%d",i);
            self.secondLabel.text = [NSString stringWithFormat:@"%d",i];
            [NSThread sleepForTimeInterval:1];
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"异步第三线程：%d",i);
            self.thirdLabel.text = [NSString stringWithFormat:@"%d",i];
            [NSThread sleepForTimeInterval:1];
        }
    });
}
#pragma mark -全局线程异步执行
- (IBAction)globelButtonClick:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
               self.firstLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.secondLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.thirdLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
}

#pragma mark - 自己创建的串行队列异步执行

- (IBAction)createButtonClick:(id)sender {
    
    dispatch_queue_t createQueue = dispatch_queue_create("create", NULL);
    dispatch_async(createQueue, ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.firstLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
    
    dispatch_async(createQueue, ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.secondLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
    
    dispatch_async(createQueue, ^{
        for (int i = 1; i < 100; i++) {
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.thirdLabel.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    });
}

#pragma mark- 全局并发队列异步加载图片

- (IBAction)imageButtonClick:(id)sender {
    
    self.firstLabel.hidden = YES;
    self.secondLabel.hidden = YES;
    self.thirdLabel.hidden = YES;
    
    self.imageView.hidden = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MBProgressHUD *hud = [self configChrysanthemum];
        NSString *str = [NSString_Addition md5ToLowerCase:@"http://static.udz.com/statics/app/images/bannerlvbb2.jpg"];
        NSData *imageData = [ImageCache loadImageData:str];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (hud != nil) {
                [self hudWasHidden:hud];
            }
            self.imageView.image = image;
        });
        
    });
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
