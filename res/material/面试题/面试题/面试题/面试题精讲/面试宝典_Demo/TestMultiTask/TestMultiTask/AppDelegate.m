//
//  AppDelegate.m
//  TestMultiTask
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
    
    
    //NSThread
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread) object:nil];
    [thread start];
    
    //Dispatch
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Dispatch ");
    });
    
    //NSOperation NSOperationQueue
    NSOperation *testNSoperation = [[NSOperation alloc] init];
    [testNSoperation setCompletionBlock:^{
        NSLog(@"NSOperation ");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc ] init];
    [queue addOperation:testNSoperation];
    
    //不会结束的线程
    [self createNoDeadThreadWithWhile];
    [self createNoDeadThreadWithRunloop];
    
    return YES;
}



-(void)thread
{
    NSLog(@"NSThread ");
}


-(void)createNoDeadThreadWithWhile
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //这里使用 while 死循环，确保了分线程始终不被销毁 ，保证timer 的有效
        while (1)
        {
            sleep(2.0);
            
            static int i = 0;
            NSLog(@"test createNoDeadThreadWithWhile  %d",i++);
        }
        
    });
}


//run loop 实现 不会结束的线程
-(void)createNoDeadThreadWithRunloop
{
    NSLog(@"createTimer");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:Nil repeats:YES];
        //这里使用 while 死循环，确保了分线程始终不被销毁 ，保证timer 的有效
//        while (1)
        {
            // waiting for new data
            if ([[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
            {
                //当该线程被触发，即会执行到这里
                // process current data

            }
        }

    });
}

-(void)test
{
    static int i = 0;
    NSLog(@"test createNoDeadThreadWithRunloop %d",i++);
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
