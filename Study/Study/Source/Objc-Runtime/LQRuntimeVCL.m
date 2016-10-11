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

@property (nonatomic,assign) SEL helloWorld;

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
    
    //获取类的名称
    [self obtainClassName];
    
}

/**
 添加方法
 */
- (void)addMethod
{
    class_addMethod([LQTestPerson class], @selector(helloWorld), class_getMethodImplementation([LQRuntimeVCL class], @selector(find)), "v@");
}

/**
 视图即将出现
 
 */
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


/**
  viewWillAppear的替代方法
 */
- (void)replaceViewAppear
{
    NSLog(@"I replace the view will appear");
}


/**
 动态给testperson添加的方法
 */
- (void)find
{
    NSLog(@"Hello world");
}


/**
 属性的实检测
 */
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

/**
 获取类的名称
 */
- (void)obtainClassName
{
    //获取testperson 类名称
    __unsafe_unretained Class class = [LQTestPerson class];
    NSString *className = [NSString stringWithCString:class_getName(class) encoding:NSUTF8StringEncoding];
    NSLog(@"LQTestPerson class name is :%@",className);
    
    //获取RUNTIME父类名称
    NSString *superClassName = [NSString stringWithCString:class_getName(class_getSuperclass([self class])) encoding:NSUTF8StringEncoding];
    NSLog(@"runtime super class is:%@",superClassName);
    
    //判断是否为metaclass
    Class superClass = [self class];
    BOOL isMetaClass = class_isMetaClass(superClass);
    NSLog(@"==%d",isMetaClass);
    Class metaClass = object_getClass(superClass);
    isMetaClass = class_isMetaClass(metaClass);
    NSLog(@"==%d",isMetaClass);
    
    //计算实例的size
    LQTestPerson *person = [[LQTestPerson alloc] init];
    size_t size = class_getInstanceSize([person class]);
    NSLog(@"size is:%d",(int)size);
    
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
