//
//  LQPhotoChooseVCL.m
//  Study
//
//  Created by 李强 on 16/8/17.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQPhotoChooseVCL.h"
#import "LQPhotoCell.h"
#import <Photos/Photos.h>

@interface LQPhotoChooseVCL ()

@property (nonatomic,strong) NSMutableArray *imageArray;

@end

@implementation LQPhotoChooseVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数组
    self.imageArray = [[NSMutableArray alloc] init];
    
    //添加返回按钮
    [self addBackButton];
    
    //title
    self.title = @"照片选择";
    
    self.collectionView.backgroundColor = COLOR_PINK;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    //照片便利
    [self getThumbnailImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 4)/2, (SCREEN_WIDTH - 4)/2 + 30);
}

#pragma mark 定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)getThumbnailImages
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        // 获得所有的自定义相簿
        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        // 遍历所有的自定义相簿
        for (PHAssetCollection *assetCollection in assetCollections) {
            [self enumerateAssetsInAssetCollection:assetCollection original:NO];
        }
        // 获得相机胶卷
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
        [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
        

        
    });
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
            //[self.collectionView reloadData];
            
            [self.imageArray addObject:result];
            
            
        }];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LQPhotoCell" forIndexPath:indexPath];
    cell.imageView.image = self.imageArray[indexPath.row];
    cell.titleLabel.text = @"111";
    return cell;
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
