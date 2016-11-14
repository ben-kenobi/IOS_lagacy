//
//  AppDelegate.m
//  TestConstString
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

/*
 观察 编译器对 常量字符串的 自动优化
 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    NSString *str = [[NSString alloc] initWithString:@"aaa"];
    [str release];
    [str release];
    [str release];
    [str release];
    NSLog(@"%@",str);
    
    [self test1];
    
    [self test2];
    
    return YES;
}

-(void)test1
{
    NSString *string1 = @"Hello";
    
    NSString *string2 = @"Hello";
    
    
    NSLog(@"string1 %p",string1);
    NSLog(@"string2 %p \n\n\n",string2);
}

-(void)test2
{
    NSString *string1 = @"Hello";
    
    //非配了内存地址
    NSString *string2 = [NSString alloc];
    
    NSString *string3 = [string2 initWithString:string1];
    
    
    NSLog(@"string1 %p",string1);
    NSLog(@"string2 %p",string2);
    NSLog(@"string3 %p \n\n\n",string3);
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
