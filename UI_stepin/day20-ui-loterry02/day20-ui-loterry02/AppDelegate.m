//
//  AppDelegate.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if(!self.window){
        self.window=[[UIWindow alloc] initWithFrame:IScreen.bounds];
        
        self.window.rootViewController=[AppDelegate vc];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

+(UIViewController *)vc{
    if([self isNewVersion]){
        [self saveVersionToPref];
        return [[NSClassFromString(@"YFIntroVC") alloc] init];
    }else{
        return [[NSClassFromString(@"YFMainCon") alloc] init];
    }
}

+(BOOL)isNewVersion{
    return ![[self versionFromPref] isEqualToString:[self curVersion]];
}
+(void)saveVersionToPref{
    [[NSUserDefaults standardUserDefaults]setObject:[self curVersion] forKey:@"version"] ;
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)versionFromPref{
    return   [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
}
+(NSString *)curVersion{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
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