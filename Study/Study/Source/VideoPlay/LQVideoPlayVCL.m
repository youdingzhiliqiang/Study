//
//  LQVideoPlayVCL.m
//  Study
//
//  Created by 李强 on 16/10/10.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQVideoPlayVCL.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LQImageFromColor.h"

typedef NS_ENUM(int,ViewTag) {
    ButtonTag = 10000,
};

@interface LQVideoPlayVCL ()

//@property (nonatomic,strong) MPMoviePlayerController *player;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *item;

@end

@implementation LQVideoPlayVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加返回按钮
    [self addBackButton];
    
    //播放方式选择
    [self videoPlayChoose];
    
    //设置title
    self.title = @"视频播放";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - 播放方式的选择

- (void)videoPlayChoose
{
    NSArray *titleArray = @[@"AVPlayer",@"MoviePlayerVCL",@"MoviePlayerController"];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 104 + 100 * i, SCREEN_WIDTH - 40, 50)];
        button.backgroundColor = [UIColor cyanColor];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = ButtonTag + i;
        [self.view addSubview:button];
    }
}

#pragma mark - 按钮点击事件

- (IBAction)buttonClick:(UIButton *)sender
{
    if (sender.tag == ButtonTag) {
        [self avPlay];
    } else if (sender.tag == ButtonTag + 1) {
        
    } else if (sender.tag == ButtonTag + 2) {
//         [self presentViewController:self.player animated:YES completion:nil];
    }
}

#pragma mark - 使用AVPlayerViewController播放网络视频

- (void)avPlay
{
    
    self.item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://down.treney.com/mov/test.mp4"]];
    
    float totalTime = CMTimeGetSeconds(self.item.asset.duration);
    
    NSLog(@"==%.2f",totalTime);
    
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(20, 424, SCREEN_WIDTH - 40, 100);
//    layer.backgroundColor = [UIColor cyanColor].CGColor;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:layer];
    
    self.player.volume = 0.0f;
    


    
    
    //监听视频播放状态
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.item addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:nil];

    
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 459,60, 30)];
    [pauseButton setTitle:@"播放" forState:UIControlStateNormal];
    [pauseButton setTitle:@"暂停" forState:UIControlStateSelected];
    pauseButton.hidden = YES;
    pauseButton.tag = 2000;
    [pauseButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pauseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 484, 55, 30)];
    label.textColor = COLOR_PINK;
    label.tag = 3000;
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat:@"%d",(int)totalTime];
    [self.view addSubview:label];
    
    __weak typeof(self) weakSelf = self;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0f , 1.0f) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        CMTime currentTime = weakSelf.item.currentTime;
        float playback = CMTimeGetSeconds(self.item.asset.duration) - CMTimeGetSeconds(currentTime);
        NSLog(@"duration: %.2f", playback);
        
//        UILabel *label = (UILabel *)[weakSelf.view viewWithTag:3000];
        label.text = [NSString stringWithFormat:@"%d",(int)playback];
    }];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(18, 524, SCREEN_WIDTH - 36, 30)];
    
    
    [slider setMinimumTrackImage:[LQImageFromColor getImageFromColor:[UIColor yellowColor]] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[LQImageFromColor getImageFromColor:[UIColor cyanColor]] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"123");
    
    if (object == self.item && [keyPath isEqualToString:@"status"]) {
        
        NSLog(@"123");
        
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            
            UIButton *button = (UIButton *)[self.view viewWithTag:2000];
            button.hidden = NO;
        }
    } else if (object == self.item && [keyPath isEqualToString:@"currentTime"]) {
        
        
        
        CMTime currentTime = self.item.currentTime;
        float time = CMTimeGetSeconds(currentTime);
        NSLog(@"duration: %.2f", time);
        
        UILabel *label = (UILabel *)[self.view viewWithTag:3000];
        label.text = [NSString stringWithFormat:@"%d",(int)time];
    }
}

#pragma mark - 暂停

- (IBAction)pauseButtonClick:(UIButton *)sender
{
    CMTime currentTime = self.item.currentTime;
    float time = CMTimeGetSeconds(currentTime);
    NSLog(@"duration: %.2f", time);
//
    
    if (sender.selected == NO) {
        [self.player play];
    } else {
        [self.player pause];
    }
    sender.selected = !sender.selected;
    
}

#pragma mark - 滑竿滑动事件

- (IBAction)sliderChange:(UISlider *)sender
{
    
}

#pragma mark - MPMoviePlayerController 播放

- (void)moviePlayerController
{
//    NSURL *url = [NSURL URLWithString:@"http;//down.treney.com/mov/test.mp4"];
//    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    self.player.view.frame = CGRectMake(10, 424,SCREEN_WIDTH - 20 , SCREEN_HEIGHT - 424 -20);
//    [self.view addSubview:self.player.view];
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
