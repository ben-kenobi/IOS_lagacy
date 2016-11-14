//
//  AppDelegate.m
//  TestKVOAndKVC
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

@interface A : NSObject  {
    @public
      NSString* foo;
}
// 其它代码
@end
@implementation A


@end

@interface B : NSObject  {
    @public
      NSString* bar;
      A* myA;
}
// 其它代码
@end
@implementation B


@end


@interface AppDelegate ()
{
    B *bobj_;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    /*KVC*/
    
    //SET
    bobj_ = [[B alloc] init];
    [bobj_ setValue:@"B_descript" forKey:@"bar"];
    A *aobj = [[A alloc] init];
    [bobj_ setValue:aobj forKeyPath:@"myA"];
    [bobj_ setValue:@"A_descript" forKeyPath:@"myA.foo"]; 
    
    
    //GET
    NSLog(@"bar %@",[bobj_ valueForKey:@"bar"]);
    NSLog(@"myA %@",[bobj_ valueForKey:@"myA"]);
    NSLog(@"myA.foo %@",[bobj_ valueForKeyPath:@"myA.foo"]);
    
    
    /*KVO addObserver*/
    //context: 可以指定 一个  nsstring，作为区分其他observer的标识
    [self addObserver:self
           forKeyPath:@"bobj_.myA.foo"
              options:0
              context:nil];//@"identifier"
    
    
    
    
    return YES;
}



#pragma mark KVO
//用来监听注册的items变量发生变化，返回的一系列的信息
//keyPath返回的就是注册的变量名－－－这边这个值为myA.foo (因为KVO中可以注册多个监听)
//object 对应keyPath所在的对象,因为 keyPath(myA.foo)是在RootViewController中声明的所以object为A对象
//change 返回的dict纪录key值为	NSKeyValueChangeKindKey、NSKeyValueChangeNewKey、NSKeyValueChangeOldKey、NSKeyValueChangeIndexesKey、NSKeyValueChangeNotificationIsPriorKey
//context返回的值是在监听的时候设置的context

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	//获取变化值
    NSString * changefoo= [change objectForKey:NSKeyValueChangeKindKey];
    NSLog(@"%@",bobj_->myA->foo);
    
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
    
    [bobj_ setValue:@"APP_EnterBackground" forKeyPath:@"myA.foo"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [bobj_ setValue:@"APP_EnterForeground" forKeyPath:@"myA.foo"];
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
