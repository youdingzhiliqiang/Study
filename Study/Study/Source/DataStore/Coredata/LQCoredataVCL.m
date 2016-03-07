//
//  LQCoredataVCL.m
//  Study
//
//  Created by 李强 on 16/2/26.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQCoredataVCL.h"
#import "Person.h"
#import "LQTitleDetailCell.h"
@interface LQCoredataVCL ()

@end

@implementation LQCoredataVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self setValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 基础设置

- (void)setValue
{
    [self createContext];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.dataSource = [[NSMutableArray alloc] init];
    [self selectData];
}

#pragma mark - 创建context

- (void)createContext
{
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"coredata.data"]];
    NSError *error = nil;
    NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:0 error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:0];
    self.context.persistentStoreCoordinator = coordinator;
}

#pragma mark - 查询数据

- (void)selectData
{
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.context];
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    for (id obj in array) {
        [self.dataSource addObject:obj];
    }
    [self.tableview reloadData];
}

#pragma mark - 保存数据

- (void)saveData
{
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.context];
    NSArray *array = [self.context executeFetchRequest:request error:&error];
   
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    person.name = [NSString stringWithFormat:@"name%d",(int)array.count+1];
    person.age = @(array.count+1);
    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
    [self selectData];
}

#pragma mark - 删除数据

- (void)deleteData
{
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.context];
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    for (id obj in array) {
        [self.context deleteObject:obj];
    }
    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
    [self selectData];
}

- (IBAction)deleteButtonClick:(id)sender {
    [self.dataSource removeAllObjects];
    [self deleteData];
}

- (IBAction)saveButtonClick:(id)sender {
    [self.dataSource removeAllObjects];
    [self saveData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQTitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQTitleDetailCell" forIndexPath:indexPath];
    Person *person = [self.dataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text = person.name;
    cell.detailLabel.text = [NSString stringWithFormat:@"%@",person.age];
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
