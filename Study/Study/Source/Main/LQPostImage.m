//
//  LQPostImage.m
//  Study
//
//  Created by 李强 on 16/7/25.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQPostImage.h"

@interface LQPostImage ()

@end

#define API_POST_IMAGE @"http://182.92.103.135:8080/hpm-app/4001"

@implementation LQPostImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self createButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建按钮

- (void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)openCamera
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册中选择", nil];
    actionSheet.delegate = self;
    actionSheet.tag = 1100;
    actionSheet.destructiveButtonIndex = -1;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

#pragma mark - method of UIActionSheet
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 1100) {//拍照
        if (buttonIndex == 0 &&  [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imgPicker=[[UIImagePickerController alloc] init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:NO];
            [self presentViewController:imgPicker animated:YES completion:^{
                
            }];
            return;
        }
        if (buttonIndex == 1) {//本地选取
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:@"public.image", nil];
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        //self.photoImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.image  = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //判断图片像素是否大于60万
    }
    
    [self dismissViewControllerAnimated:NO completion:^{
        [self postImageWithImage:self.image];
    }];
    
}

//- (void)postImage
//{
//    UIImage *image = [UIImage imageNamed:@"电影"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:API_POST_IMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"filedata" fileName:@"filedata" mimeType:@"image/png"];
//    } error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:^(NSProgress * _Nonnull uploadProgress) {
//                  }
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      if (error) {
//
//                      } else {
//                          NSLog(@"%@ ", responseObject);
//                          [self showMBProgressWithText:@"上传成功"];
//                      }
//                  }];
//    [uploadTask resume];
//}

- (void)postImageWithImage:(UIImage *)image
{
    //UIImage *image = [UIImage imageNamed:@"电影"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
//    AFURLSessionManager *manage = [AFURLSessionManager ]
    MBProgressHUD *hud = [self configChrysanthemum];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_POST_IMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"filedata" fileName:@"filedata" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hudWasHidden:hud];
        NSLog(@"===%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hudWasHidden:hud];
        NSLog(@"Error:  %@",error);
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
