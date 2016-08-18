//
//  LQImageTitleCell.h
//  Study
//
//  Created by 李强 on 16/8/18.
//  Copyright © 2016年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQImageTitleCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;

- (void)adjustImage:(UIImage *)image
         imageWidth:(float)imageWidth
        imageHeight:(float)imageHeight
         titleWidth:(float)titleWidth
        titleHeight:(float)titleHeight
              title:(NSString *)title;
@end
