//
//  LQCellAdjustTCL.m
//  Study
//
//  Created by 李强 on 16/3/24.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQCellAdjustTCL.h"
#import "LQCellAdjust.h"
@interface LQCellAdjustTCL ()
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@end

@implementation LQCellAdjustTCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
        [_dataSourceArray addObject:@"不久前，河南郑州某学院的一名在校大学生因为无力偿还共计几十万的各种网络贷款，最终跳楼自杀，这是校园网络贷款的一个极端案例。悲剧背后，疯狂生长的校园“网贷”被推到舆论的风口浪尖。自2014年起，专门针对大学生这一庞大群体的网络贷款开始了“跑马圈地”，“XX贷”们雨后春笋般冒出来。如今，校园网贷究竟风行到什么程度？借来的钱学生们会怎么花掉？千差万别的贷款平台审核是否有疏漏？号称“月息低到0.99%、最高可借50000，5秒可到账”，真如商家所说的如此无门槛“低息”？对此，北京青年报记者展开了调查。"];
        [_dataSourceArray addObject:@"我是来打酱油的"];
    }
    return _dataSourceArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _dataSourceArray[indexPath.row];
    //计算文字的高度
    CGFloat height = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120 - 12, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_16} context:nil].size.height;
    if (height >= 65) {
        height = 65;
    }
    if (height <= 65) {
        height = 65;
    }
    return height + 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQCellAdjust *cell = [tableView dequeueReusableCellWithIdentifier:@"LQCellAdjust" forIndexPath:indexPath];
    cell.mainImageView.image = [UIImage imageNamed:@"篮球"];
    UILabel *label = [self reSetFrameOfCellTitleLabel:cell.titleLabel indexPath:indexPath];
    label.text = _dataSourceArray[indexPath.row];
    cell.deatilButton.tag = indexPath.row + 100;
    return cell;
}

#pragma mark - 改变cell 中titleLabel中的尺寸
- (UILabel *)reSetFrameOfCellTitleLabel:(UILabel *)label indexPath:(NSIndexPath *)indexPath
{
    NSString *str = _dataSourceArray[indexPath.row];
    //计算文字的高度
    CGFloat height = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120 - 12, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_16} context:nil].size.height;
    if (height <= 65) {
        CGRect frame = label.frame;
        frame.size.height = height;
        label.frame = frame;
        return label;
    }
    return label;
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
