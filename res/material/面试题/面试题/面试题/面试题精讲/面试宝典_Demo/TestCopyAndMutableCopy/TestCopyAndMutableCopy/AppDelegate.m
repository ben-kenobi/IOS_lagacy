//
//  AppDelegate.m
//  TestCopyAndMutableCopy
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
@interface  QFObject : NSObject<NSCopying,NSMutableCopying>
{
    NSMutableString *name;
    NSString *imutableStr;
    int age;
}
@property (nonatomic, retain) NSMutableString *name;
@property (nonatomic, retain) NSString *imutableStr;
@property (nonatomic) int age;
@end



@implementation  QFObject
@synthesize name;
@synthesize age;
@synthesize imutableStr;
- (id)init
{
    if (self = [super init])
    {
        self.name = [[NSMutableString alloc]initWithString:@"Logger"];
        self.imutableStr = [[NSString alloc]initWithString:@"Desc"];
        age = -1;
    }
    return self;
}
- (void)dealloc
{
    [name release];
    [imutableStr release];
    [super dealloc];
}
- (id)copyWithZone:(NSZone *)zone
{
    QFObject *copy = [[[self class] allocWithZone:zone] init];
    copy->name = [name copy];
    copy->imutableStr = [imutableStr copy];
    copy->age = age;
    return copy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    QFObject *copy = [[[self class] allocWithZone:zone] init];
    copy->imutableStr = [imutableStr copy];
    copy->name = [name mutableCopy];
    copy->age = age;
    return copy;
}

@end



int global_Value = 1;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //非容器类的 copy
    //    NSString *string = @"origion";
    //    NSString *stringCopy = [string copy];
    //    NSMutableString *stringMCopy = [string mutableCopy];
    
    //    NSMutableString *string = [NSMutableString stringWithString: @"origion"];
    //    NSString *stringCopy = [string copy];
    //    NSMutableString *mStringCopy = [string copy];
    //    NSMutableString *stringMCopy = [string mutableCopy];
    //    //[mStringCopy appendString:@"mm"];//error
    //    [string appendString:@" origion!"];
    //    [stringMCopy appendString:@"!!"];
    //
    //    NSNumber *number = [NSNumber numberWithInt:1111];
    //    NSNumber *numbercopy = [number copy];
    //奔溃
    //    NSNumber *numbermcopy = [number mutableCopy];
    
    
    
    //容器类的 copy
    //    NSArray *array1 = [NSArray arrayWithObjects:@"a",@"b",@"c",nil];
    //    NSArray *arrayCopy1 = [array1 copy];
    //    //arrayCopy1是和array同一个NSArray对象（指向相同的对象），包括array里面的元素也是指向相同的指针
    //    NSLog(@"array1 retain count: %d",[array1 retainCount]);
    //    NSLog(@"array1 retain count: %d",[arrayCopy1 retainCount]);
    //    NSMutableArray *mArrayCopy1 = [array1 mutableCopy];
    
    
    //     NSArray *mArray1 = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    //     NSArray *mArrayCopy2 = [mArray1 copy];
    //     NSLog(@"mArray1 retain count: %d",[mArray1 retainCount]);
    //     NSMutableArray *mArrayMCopy1 = [mArray1 mutableCopy];
    //     NSLog(@"mArray1 retain count: %d",[mArray1 retainCount]);
    //     //mArrayCopy2,mArrayMCopy1和mArray1指向的都是不一样的对象，但是其中的元素都是一样的对象——同一个指针
    //     //一下做测试
    //     NSMutableString *testString = [mArray1 objectAtIndex:0];
    //     //testString = @"1a1";//这样会改变testString的指针，其实是将@“1a1”临时对象赋给了testString
    //    [testString appendString:@" tail"];//这样以上三个数组的首元素都被改变了
    
    
    
    //自定义类的 copy
    QFObject * qfbject = [[ QFObject alloc] init];
    QFObject * qfbjectmcopy = [qfbject mutableCopy];
    [qfbjectmcopy.name appendString:@"mcopy"];
    
    //崩溃
    //    QFObject * qfbjectcopy = [qfbject copy];
    //    [ qfbjectcopy.name appendString:@"mcopy"];
    
    //    QFObject *qfobj = [[QFObject alloc] init];
    //    qfobj.num = [NSNumber numberWithInt:1111];
    //
    //    QFObject *qfobjCopy = [qfobj copy];
    //    [qfobj release];
    
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
