//
//  AppDelegate.m
//  TestAutoReleasePool
//
//  Created by qianfeng on 14-6-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    /*
     注意 ARC  MRC 环境下 的区别
     
     ARC 环境下 不需要优化
     for (int i = 0; i < 100000000; i++) {
     NSMutableString *str = [[NSMutableString alloc] initWithString:@"FFFFFF"];
     [str appendString:@"11"];
     }
     
     MRC 环境下 需要优化
     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
     for (int i = 0; i < 100000000; i++) {
     NSMutableString *str = [[[NSMutableString alloc] initWithString:@"FFFFFF"] autorelease];
     [str appendString:@"11"];
     if(i%1000)
     {
     [pool release];
     pool = [[NSAutoreleasePool alloc] init];
     }
     }
     
     */
    
    
    //当前环境 MRC 环境
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (int i = 0; i < 100000000; i++) {
        NSMutableString *str = [[[NSMutableString alloc] initWithString:@"FFFFFF"] autorelease];
        [str appendString:@"11"];
        if(i%1000)
        {
            [pool release];
            pool = [[NSAutoreleasePool alloc] init];
        }
    }
    [pool release];
    
    
    
    return YES;
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
    NSLog(@"自动释放");
    [pool release];
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
