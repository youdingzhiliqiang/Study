//
//  LQPostImage.h
//  Study
//
//  Created by 李强 on 16/7/25.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"

@protocol PostImageDelegate;

@protocol PostImageDelegate <NSObject>


@end

@interface LQPostImage : LQBaseVCL <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImage *image;

@end
