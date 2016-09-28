//
//  LQRuntimeVCL.m
//  Study
//
//  Created by 李强 on 16/9/28.
//  Copyright © 2016年 李强. All rights reserved.
//

#import "LQRuntimeVCL.h"
#import "LQTestPerson.h"
#import <objc/runtime.h>

@interface LQRuntimeVCL ()

@end

@implementation LQRuntimeVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加返回按钮
    [self addBackButton];
    
    //person动态添加方法
    [self addMethod];
    
    //动态方法调用
    LQTestPerson *person = [[LQTestPerson alloc] init];
    [person performSelector:@selector( helloWorld)];
    
    //方法交换
    [self exchangeMethod];
    
    //属性检测
    [self personPropertyTest];
    
}

/**
 添加方法
 */
- (void)addMethod
{
    class_addMethod([LQTestPerson class], @selector(helloWorld), class_getMethodImplementation([LQRuntimeVCL class], @selector(find)), "v@");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated ];
    NSLog(@"123");
}

/**
 方法交换
 */
- (void)exchangeMethod
{
    Method old = class_getInstanceMethod([LQRuntimeVCL class], @selector(viewWillAppear:));
    Method new = class_getInstanceMethod([LQRuntimeVCL class], @selector(replaceViewAppear));
    method_exchangeImplementations(old, new);
}

- (void)replaceViewAppear
{
    NSLog(@"I replace the view will appear");
}

- (void)find
{
    NSLog(@"Hello world");
}

- (void)personPropertyTest
{
    Class classObject = objc_getClass("LQTestPerson");
    NSLog(@"%@", NSStringFromClass(classObject));
    unsigned int propertyListNum = 0;
    unsigned int ivarlistNum = 0;
    objc_property_t *propertyList = class_copyPropertyList(classObject, &propertyListNum);
    
    Ivar *ivars = class_copyIvarList(classObject, &ivarlistNum);
    
    
    NSLog(@"propertyListNum:%d   ivarListNum:%d",propertyListNum,ivarlistNum);
    
    for (int i = 0; i < propertyListNum;i++) {
        
        objc_property_t name = propertyList[i];
        
        NSString *propertyName = [NSString stringWithCString:property_getName(name) encoding:NSUTF8StringEncoding];
        
        NSLog(@"propertyName:%@",propertyName);
    }
    
    for (int i = 0; i < ivarlistNum; i++) {
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSLog(@"-----ivarNmae:%@",ivarName);
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
