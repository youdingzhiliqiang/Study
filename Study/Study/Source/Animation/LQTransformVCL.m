//
//  LQTransformVCL.m
//  Study
//
//  Created by 李强 on 16/2/23.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQTransformVCL.h"

@interface LQTransformVCL ()
@property (nonatomic,assign) int rotationNum;
@end

@implementation LQTransformVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTapGest];
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - imageview添加手势
- (void)addTapGest
{
    UITapGestureRecognizer *tap;
    if ([[self.params objectForKey:@"animation"] isEqualToString:@"transform"]) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transformAnimatin)];
    } else if ([[self.params objectForKey:@"animation"] isEqualToString:@"scale"]) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleAnimation)];
    } else if ([[self.params objectForKey:@"animation"] isEqualToString:@"rotation"]){
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAnimation)];
    } else if ([[self.params objectForKey:@"animation"] isEqualToString:@"bounce"]) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bounceAnimation)];
    } else if ([[self.params objectForKey:@"animation"] isEqualToString:@"flip"]) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipAnimation)];
    }
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
}

- (void)transformAnimatin
{
    [UIView animateWithDuration:1 animations:^{
        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 50, 50);
    }];
}

- (void)scaleAnimation
{
    [UIView animateWithDuration:1 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)rotationAnimation
{
    [UIView animateWithDuration:1 animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI*(++self.rotationNum));
    }];
}

- (void)bounceAnimation
{
    self.imageView.layer.cornerRadius = 50;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
        CGPoint bouncePoint;
        bouncePoint.x = 100;
        bouncePoint.y = 150;
        self.imageView.center = bouncePoint;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)flipAnimation
{
    [UIView transitionWithView:self.imageView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        if ([self.imageView.image isEqual:[UIImage imageNamed:@"篮球"]]) {
            self.imageView.image = [UIImage imageNamed:@"跑步"];
        } else {
            self.imageView.image = [UIImage imageNamed:@"篮球"];
        }
    } completion:^(BOOL finished) {
        
    }];
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
