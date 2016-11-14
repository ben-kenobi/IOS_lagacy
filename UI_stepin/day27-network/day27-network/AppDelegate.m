//
//  AppDelegate.m
//  day27-network
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LoginNoti object:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:LogoutNoti object:0];
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
    if([iPref(0)objectForKey:pwdkey]){
        [self home];
    }else{
        [self loginpage];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)login:(NSNotification *)noti{
    [iPref(0) setObject:noti.userInfo[pwdkey] forKey:pwdkey];
    [iPref(0) setObject:noti.userInfo[usernamekey] forKey:usernamekey];
    [iPref(0) synchronize];
    [self home];
}
-(void)logout:(NSNotification *)noti{
    [iPref(0) removeObjectForKey:pwdkey];
    [self loginpage];
}

-(void)home{
    self.window.rootViewController=[[NSClassFromString(@"AdditionalVC") alloc] init];
}
-(void)loginpage{
    self.window.rootViewController=[[NSClassFromString(@"AdditionalVC") alloc] init];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
