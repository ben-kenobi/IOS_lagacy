//
//  AppDelegate.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>



@interface AppDelegate ()

@end

@implementation AppDelegate
-(void)dealloc{
    [iNotiCenter removeObserver:self];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window=[[UIWindow alloc] initWithFrame:iScreen.bounds];
    [self setRootVC];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
//    [application setStatusBarHidden:YES];
    
    
//    [[UINavigationBar appearance] setTintColor:iColor(21,188, 173, 1)];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:iColor(21,188, 173, 1)}];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
    [iNotiCenter addObserver:self selector:@selector(setRootVC) name:GUIDENOTI object:0];
   
    
    
    [AVOSCloud setApplicationId:@"EgWHa1OhmxYsz2gODjbsGtgn-gzGzoHsz"
                      clientKey:@"CYk28Mls72eG8uPHnU0KPDNE"];
    // 跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    return YES;
}
//invoke by external app
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSLog(@"callback----%@",url);
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        
//    }
//    return result;
    return nil;
}



-(void)setRootVC{
    self.window.rootViewController=[AppDelegate vc];
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
   UIBackgroundTaskIdentifier taskID=[application beginBackgroundTaskWithExpirationHandler:^{
       
   }];
    if(taskID != UIBackgroundTaskInvalid){
        [iApp endBackgroundTask:taskID];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveContext];
}




#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "operation11.ZYMusicPlayer" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZYMusicPlayer" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZYMusicPlayer.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



















@end
