//
//  AppDelegate.m
//  TestUDID
//
//  Created by qianfeng on 14-6-18.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LNMUIDevice+IdentifierAddition.h"


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation AppDelegate

//MAC ADDRESS 7.0 以后 无效
//http://stackoverflow.com/questions/677530/how-can-i-programmatically-get-the-mac-address-of-an-iphone
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}


- (NSString*)getIDFAIdentifier {
    NSString *idfaIdentifier = nil;
    id idfaObject = nil;
    Class class = NSClassFromString(@"ASIdentifierManager");
    id object = [class performSelector:@selector(sharedManager)];
    //使用IFA作为唯一标识符
    //IOS6.0以上用IFA
    if ([object respondsToSelector:@selector(advertisingIdentifier)]) {
        idfaObject = [object performSelector:@selector(advertisingIdentifier)];
        idfaIdentifier = [idfaObject performSelector:@selector(UUIDString)];
    }
    else {
        
    }
    
    return idfaIdentifier;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    //MAC ADDRESS 7.0 以后 无效
    //http://stackoverflow.com/questions/677530/how-can-i-programmatically-get-the-mac-address-of-an-iphone
    NSLog(@"uniqueDeviceIdentifier %@",[[UIDevice currentDevice] uniqueDeviceIdentifier]);
    
    
    NSLog(@"uniqueGlobalDeviceIdentifier %@",[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]);
    NSLog(@"sourceUniqueGlobalDeviceIdentifier %@",[[UIDevice currentDevice] sourceUniqueGlobalDeviceIdentifier]);
    
    
    //UDID
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    NSLog(@"CFUUIDRef %@",cfuuid);
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSLog(@"NSUUID %@",uuid);
    
    //IDFA  6.0后有效
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"ASIdentifierManager %@",adId);
    
    //Vendor 6.0后有效
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"identifierForVendor %@",idfv);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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
