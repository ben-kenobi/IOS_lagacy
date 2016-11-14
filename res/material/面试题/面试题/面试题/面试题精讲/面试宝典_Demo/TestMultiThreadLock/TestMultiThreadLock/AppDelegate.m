//
//  AppDelegate.m
//  TestMultiThreadLock
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    NSMutableArray *taskArr_;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    taskArr_ = [NSMutableArray arrayWithObjects:@"F1",@"F2",@"F3", nil];
    
    
    
    [self testDeadLock];
    
    return YES;
}


#pragma mark - @synchronized()

-(void)useSyncLock
{
    
    dispatch_async(dispatch_queue_create("TEST1", 0), ^{
        /*
         注意此处 不能@synchronized（nil）
         */
        @synchronized(taskArr_)
        {
            for(int i = 0;i < 10;i ++)
            {
                NSLog(@"Add111 %d",taskArr_.count);
                [taskArr_ addObject:[NSString stringWithFormat:@"F%d",taskArr_.count]];
            }
            
            /*
             如果没有其他线程对taskArr_的修改，这个地方肯定是可以拿到index 为 11 的对象的
             
             如果不加锁，此处就很容易崩溃，这就是 多线程对数据块的读写不加锁的弊端
             */
            NSLog(@"Add222 %@",[taskArr_ objectAtIndex:11]);
        }
        
    });
    
    dispatch_async(dispatch_queue_create("TEST2", 0), ^{
        static int i = 10;
        
        @synchronized(taskArr_)
        {
            while (i-- > 0) {
                NSLog(@"Remove111 %d",taskArr_.count);
                if(taskArr_.count > 5)
                {
                    NSLog(@"Remove222 %d",taskArr_.count);
                    
                    [taskArr_ removeObjectsInRange:NSMakeRange(5, taskArr_.count - 5)];
                    
                    NSLog(@"Remove333 %d",taskArr_.count);
                }
                
                NSLog(@"Remove444 %d",taskArr_.count);
            }
        }
        
    });
    
}


#pragma mark - NSLock

-(void)useNSLockLock
{
    NSLock *lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_queue_create("TEST1", 0), ^{
        
        [lock lock];
        
        for(int i = 0;i < 10;i ++)
        {
            NSLog(@"Add111 %d",taskArr_.count);
            [taskArr_ addObject:[NSString stringWithFormat:@"F%d",taskArr_.count]];
        }
        
        NSLog(@"Add222 %@",[taskArr_ objectAtIndex:11]);
       
        [lock unlock];
    });
    
    dispatch_async(dispatch_queue_create("TEST2", 0), ^{
        static int i = 10;
        [lock lock];
        
        while (i-- > 0) {
            NSLog(@"Remove111 %d",taskArr_.count);
            if(taskArr_.count > 5)
            {
                NSLog(@"Remove222 %d",taskArr_.count);
                
                [taskArr_ removeObjectsInRange:NSMakeRange(5, taskArr_.count - 5)];
                
                NSLog(@"Remove333 %d",taskArr_.count);
            }
            
            NSLog(@"Remove444 %d",taskArr_.count);
        }
        
        [lock unlock];
    });
    
}


#pragma mark - DeadLock

-(void)testDeadLock
{
    
    NSObject *objA = [[NSObject alloc] init];
    NSObject *objB= [[NSObject alloc] init];
    dispatch_async(dispatch_queue_create("TEST1", 0), ^{
        @synchronized(objB)
        {
            NSLog(@"sync objB->objA  Begin");
            
            NSLog(@"sync objB->objA 子线程 时间片运行结束 ");
            
            sleep(10.0);
            
            NSLog(@"sync objB->objA 子线程 时间片运行开始，等待objA 解锁");
            
            //此处主线程 占用了 objA，子线程阻塞，等待objA 解锁
            @synchronized(objA)
            {
                NSLog(@"sync objB->objA %@",[objA description]);
            }
        }
    });
    
//    dispatch_async(dispatch_queue_create("TEST1", 0), ^{
//        @synchronized(objA)
//        {
//            @synchronized(objB)
//            {
//                NSLog(@"sync objA->objB %@",[objA description]);
//            }
//        }
//    });
    
    
    /*
     一般情况，嵌套使用@synchronized（）没有任何问题
     
     但是当多个线程嵌套使用@synchronized（），且占用资源的顺序相反时，出现死锁
     
     因为时间片的分配的随机性，只能偶尔得出以下输出结果：
     
     2014-07-10 10:57:16.123 TestMultiThreadLock[884:a0b] sync objA->objB  Begin
     2014-07-10 10:57:16.124 TestMultiThreadLock[884:a0b] sync objA->objB 主线程 时间片运行结束
     2014-07-10 10:57:16.123 TestMultiThreadLock[884:1503] sync objB->objA  Begin
     2014-07-10 10:57:16.125 TestMultiThreadLock[884:1503] sync objB->objA 子线程 时间片运行结束
     2014-07-10 10:57:17.125 TestMultiThreadLock[884:a0b] sync objA->objB 主线程 时间片开始 等待objB 解锁
     2014-07-10 10:57:26.127 TestMultiThreadLock[884:1503] sync objB->objA 子线程 时间片运行开始，等待objA 解锁
     
     */
    @synchronized(objA)
    {
        NSLog(@"sync objA->objB  Begin");
        
        //
        // 主线程 时间片运行结束，运行子线程 TEST1
        //
        
        NSLog(@"sync objA->objB 主线程 时间片运行结束 ");
        
        sleep(1.0);
        
        
        NSLog(@"sync objA->objB 主线程 时间片开始 等待objB 解锁");
        //此处子线程 占用了 objB ， 主线程阻塞，等待objB 解锁
        @synchronized(objB)
        {
            NSLog(@"sync objA->objB %@",[objA description]);
        }
    }
    
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
