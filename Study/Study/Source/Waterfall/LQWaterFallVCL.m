//
//  LQWaterFallVCL.m
//  Study
//
//  Created by 李强 on 16/8/18.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQWaterFallVCL.h"
#import "LQImageTitleCell.h"

#define IMAGE_WIDTH ((SCREEN_WIDTH - 20 - 6)/2.0)
#define CELL_IDENTIFIER @"WaterfallCell"
#define TITLE_STR @"中国商务部发言人沈丹阳17日对澳洲电网项目一事表示高度关注，称澳方的决定明显有保护主义倾向，严重影响中国企业对澳投资的积极性。中国国家电网公司已经跟踪澳洲电网商业项目较长时间，并进入约束性竞价阶段。沈丹阳说，中方注意到，这是澳大利亚政府今年第二次做出不支持中国企业赴澳从事商业性投资申请的决定。"

@interface LQWaterFallVCL ()
{
    UICollectionView *_collectionView;
    NSMutableArray *_sizeArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_imageHeightArray;
    NSMutableArray *_titleHeightArray;
}



@end

@implementation LQWaterFallVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加返回按钮
    [self addBackButton];
    
    //添加数据源
    [self createDataSource];
    
    //添加collectionview
    [self createCollectionView];
    
    //设置title
    self.title = @"瀑布流";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectionView
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 15;
    layout.footerHeight = 10;
    layout.minimumColumnSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[LQImageTitleCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
//    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
//        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
//               withReuseIdentifier:HEADER_IDENTIFIER];
//    [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
//        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
//               withReuseIdentifier:FOOTER_IDENTIFIER];
    [self.view addSubview:_collectionView];
}

- (void)createDataSource
{
    _imageArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _sizeArray = [[NSMutableArray alloc] init];
    _imageHeightArray = [[NSMutableArray alloc] init];
    _titleHeightArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 16; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"image%.2d.jpg",i];
        UIImage *image = [UIImage imageNamed:imageStr];
        
        [_imageArray addObject:image];

        
        NSMutableString *str = [[NSMutableString alloc] init];
        for (int j = 0; j <= i; j++) {
            [str appendString:TITLE_STR];
        }
        
        [_titleArray addObject:str];
        
        float imageHeight = image.size.width/image.size.height*IMAGE_WIDTH;
        
        [_imageHeightArray addObject:[NSNumber numberWithFloat:imageHeight]];
        
        float titleHeight = [str boundingRectWithSize:CGSizeMake(IMAGE_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        
        [_titleHeightArray addObject:[NSNumber numberWithFloat:titleHeight]];
        
        CGSize cellSize = CGSizeMake(IMAGE_WIDTH, imageHeight + titleHeight);
        
        NSValue *sizeValue = [NSValue valueWithCGSize:cellSize];
        
        [_sizeArray addObject:sizeValue];
        
    }
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_sizeArray[indexPath.row] CGSizeValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQImageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell adjustImage:_imageArray[indexPath.row] imageWidth:IMAGE_WIDTH imageHeight:[_imageHeightArray[indexPath.row] floatValue] titleWidth:IMAGE_WIDTH titleHeight:[_titleHeightArray[indexPath.row] floatValue] title:_titleArray[indexPath.row]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"+++%d",indexPath.row);
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
