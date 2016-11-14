//
//  AppDelegate.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "QFClassA.h"
#import "QFClassB.h"
#import "QFClassA+ClassBInheritance.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //一般单继承
    QFClassA *qfa = [[QFClassA alloc] init];
    
    printf("\n\n********************继承 的属性  ********************\n");
    [qfa printOwnerProperties];
    printf("*******************************************************\n");
    
    /*模拟多继承*/
    QFClassA *aobj = [[QFClassA alloc] init];
    
    printf("\n********************继承 的Category 接口 ********************\n");
    //使用Category 实现 多接口
    [aobj CategoryDescription];
    printf("\n************************************************************\n");
    
    
    printf("\n*****Category + Runtime(组合)方式实现属性和方法的继承 ***********\n");
    //使用Category + Runtime(组合) 实现属性和方法的继承
    [aobj performSelector:@selector(methodB) withObject:nil];
    [aobj.classBInstance methodB];
    printf("\n**********************************************************\n");
    
    
    QFClassB *bobj = [[QFClassB alloc] init];
    
    printf("\n*****************使用协议(Protocol)实现类簇的概念***************\n");
    [self printClassFamily:aobj];
    [self printClassFamily:bobj];
    printf("\n**********************************************************\n");
    
    return YES;
}


-(void)printClassFamily:(id<QFProtocol>)obj
{
    [obj QFDescription];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
