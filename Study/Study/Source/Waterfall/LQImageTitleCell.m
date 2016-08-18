//
//  LQImageTitleCell.m
//  Study
//
//  Created by 李强 on 16/8/18.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQImageTitleCell.h"

@implementation LQImageTitleCell


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.backgroundColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)adjustImage:(UIImage *)image
         imageWidth:(float)imageWidth
        imageHeight:(float)imageHeight
         titleWidth:(float)titleWidth
        titleHeight:(float)titleHeight
              title:(NSString *)title;
{
    self.imageView.image = image;
    self.titleLabel.text = title;
    self.imageView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
    self.titleLabel.frame = CGRectMake(0,imageHeight, titleWidth, titleHeight);
}

@end
