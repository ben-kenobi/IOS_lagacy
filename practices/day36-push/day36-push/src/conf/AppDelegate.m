//
//  AppDelegate.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//remote notification

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"remote noti:%@",userInfo);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    NSLog(@"identifier:=%@",identifier);
    completionHandler();
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken===%@",deviceToken);
}



//local notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"local noti:%@",notification);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
    NSLog(@"identifier:=%@",identifier);
    completionHandler();
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //register remote notification
    UIMutableUserNotificationCategory *cate=[[UIMutableUserNotificationCategory alloc] init];
    cate.identifier=@"remoteiden";
    UIMutableUserNotificationAction *ac1=[[UIMutableUserNotificationAction alloc] init];
    ac1.identifier=@"action1";
    ac1.title=@"action1";
    UIMutableUserNotificationAction *ac2=[[UIMutableUserNotificationAction alloc] init];
    ac2.identifier=@"action2";
    ac2.title=@"action2";
    [cate setActions:@[ac1,ac2] forContext:UIUserNotificationActionContextDefault];
    
    [iApp registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:    UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert  categories:[NSSet setWithObjects:cate, nil]]];
    [iApp registerForRemoteNotifications];
    
    
    

    if(launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]){
        [iApp setApplicationIconBadgeNumber:3];
    }else if(launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]){
        
    }else{
        [iApp setApplicationIconBadgeNumber:0];
    }
    
    self.window=[[UIWindow alloc] initWithFrame:iScreen.bounds];
    self.window.rootViewController=[AppDelegate rootVC:NO];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [application setStatusBarHidden:YES];
    
    
    [[UINavigationBar appearance] setTintColor:iColor(21,188, 173, 1)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:iColor(21,188, 173, 1)}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
    return YES;
}




+(UIViewController *)vc{
    NSString *ver=[iPref(0) objectForKey:@"appVersion"];
    NSString *curver=[iBundle infoDictionary][@"CFBundleShortVersionString"];
    if([ver isEqualToString:curver]){
        return [self rootVC:YES];
    }else{
        [iPref(0) setObject:curver forKey:@"appVersion"];
        [iPref(0) synchronize];
        return [[NSClassFromString(iRes4dict(@"conf.plist")[@"introVC"]) alloc] init];
    }
}
+(UIViewController *)rootVC:(BOOL)lock{
    if( [iPref(@"settingPref") boolForKey:@"lockScreen"]&&lock){
        return [[NSClassFromString(iRes4dict(@"conf.plist")[@"lockVC"]) alloc] init];
    }else{
        return  [[NSClassFromString(iRes4dict(@"conf.plist")[@"rootVC"]) alloc] init];
    }
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
