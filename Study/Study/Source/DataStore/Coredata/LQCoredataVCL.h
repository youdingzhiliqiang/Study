//
//  LQCoredataVCL.h
//  Study
//
//  Created by 李强 on 16/2/26.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQBaseVCL.h"
#import <CoreData/CoreData.h>
@interface LQCoredataVCL : LQBaseVCL <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end
