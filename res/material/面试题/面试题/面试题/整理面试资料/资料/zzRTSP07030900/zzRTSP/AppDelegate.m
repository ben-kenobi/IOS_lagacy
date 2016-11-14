//
//  AppDelegate.m
//  zzRTSP
//
//  Created by zz on 14-6-3.
//  Copyright (c) 2014年 YunFeng. All rights reserved.
//

//
//  AppDelegate.m
//  Radio
//
//  Created by Planet1107 on 1/28/12.
//

#import "AppDelegate.h"
#import "CategoryViewController.h"
#import "RecentViewController.h"
#import "FavoritesViewController.h"
#import "SettingsViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    UINavigationController *categoryNavigationController = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
   
    //设置返回按钮
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    categoryNavigationController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
  
    categoryNavigationController.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//     categoryViewController.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
    
    //设置到航栏主题
    // 1.获得appearance对象, 就能修改主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor  whiteColor]];
 
  
    #warning 注释---是否需要加判断

#warning 注释---恢复黑色,
    [navBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

//    navBar.barTintColor = [UIColor  blueColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        // 设置文字颜色
        textAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
        // 去掉阴影
        textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
        // 设置文字字体
        textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:16.5];
        [navBar setTitleTextAttributes:textAttrs];


    
    
    
    
    categoryNavigationController.navigationBar.backgroundColor = [UIColor colorWithRed:11 green:104 blue:210 alpha: 0.0];
    
    categoryNavigationController.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];

    categoryNavigationController.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -6);
    categoryNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab-categories.png"];
    
    [categoryNavigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [categoryViewController release];
    
    RecentViewController *recentViewController = [[RecentViewController alloc] initWithNibName:@"RecentViewController" bundle:nil];
    UINavigationController *recentNavigationController = [[UINavigationController alloc] initWithRootViewController:recentViewController];
    recentViewController.tabBarItem.image = [UIImage imageNamed:@"tab-recent.png"];
        recentViewController.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -6);
    [recentNavigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [recentViewController release];
    
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    UINavigationController *favoritesNavigationController = [[UINavigationController alloc] initWithRootViewController:favoritesViewController];
    favoritesNavigationController.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
       favoritesViewController.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -6);
    
    
    favoritesViewController.tabBarItem.image = [UIImage imageNamed:@"tab-favorites.png"];
    
    
    favoritesViewController.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -6);
 
    
    [favoritesNavigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [favoritesViewController release];
    
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    settingsNavigationController.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];

    
    settingsViewController.tabBarItem.image = [UIImage imageNamed:@"tab-settings.png"];
    [settingsNavigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
        settingsViewController.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -6);
    [settingsViewController release];
    
    UITabBarController *tabBarController = [[[UITabBarController alloc] init] autorelease];
#warning 注释---应该提供一条线
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tbabarbg"];
 
 
//正常文字的颜色
    NSMutableDictionary *textAttrs1 = [NSMutableDictionary dictionary];
    // 设置文字颜色
    textAttrs1[UITextAttributeTextColor] = [UIColor whiteColor];
    // 去掉阴影
    textAttrs1[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 20)];
    // 设置文字字体
    textAttrs1[UITextAttributeFont] = [UIFont boldSystemFontOfSize:17];
//    [navBar setTitleTextAttributes:textAttrs1];
    [tabBarController.tabBarItem setTitleTextAttributes:textAttrs1 forState:UIControlStateNormal];
    tabBarController.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 10, -10, 0);
 

    
//高亮文字的颜色
    NSMutableDictionary *textAttrs2 = [NSMutableDictionary dictionary];
    // 设置文字颜色
    textAttrs2[UITextAttributeTextColor] = [UIColor orangeColor];
    // 去掉阴影
    textAttrs2[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    // 设置文字字体
    textAttrs2[UITextAttributeFont] = [UIFont boldSystemFontOfSize:14.5];
    //    [navBar setTitleTextAttributes:textAttrs1];
    [tabBarController.tabBarItem setTitleTextAttributes:textAttrs2 forState:UIControlStateHighlighted];
    //34 79 156
    //14 90 201

    
    [tabBarController setViewControllers:[NSArray arrayWithObjects:categoryNavigationController, recentNavigationController, favoritesNavigationController, settingsNavigationController, nil]];
    self.window.rootViewController = tabBarController;
      [temporaryBarButtonItem release];
    [categoryNavigationController release];
    [recentNavigationController release];
    [favoritesNavigationController release];
    [settingsNavigationController release];
    
//    //添加颜色
//    UIView *view =[[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithRed:34 green:79 blue:156 alpha:0.5];
//    view.frame = CGRectMake(0, 0, 320, 90);
//    [self.window addSubview:view];
//    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

