//
//  MTExceptionHandler.h
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/**
 Usage: 
 1, set corresponding exception file name, in somewhere
 [MTExceptionHandler setCaughtExceptionFile:@"unhandled.txt];
 [MTExceptionHandler setExceptionFile:@"handled.txt"];
 
 2,set uncaught exception
 add [MTExceptionHandler setExceptionHandler];
 in
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
 3, record the exception in user's own code
 cactch (NSException *exception) {
 [MTExceptionHandler handleException:exception];
 .... // you own codes
 }
*/

#import <Foundation/Foundation.h>

@interface MTExceptionHandler : NSObject
{
    NSString *_uncaughtFileName;
    NSString *_caughtFileName;
}

@property (nonatomic, retain) NSString *uncaughtFile;
@property (nonatomic, retain) NSString *caughtFile;

+ (MTExceptionHandler *)sharedInstance;

// install the exception handler
+ (void)setExceptionHandler;
// set the file name which store the uncaught exceptions
// fileName: relative file path, file name only
+ (void)setExceptionFile:(NSString *)fileName;
// set the file name which store the caught exceptions
// fileName: relative file path, file name only
// NOTE: if this wasn't set, can be caught exceptions will be record into uncaught exception file
+ (void)setCaughtExceptionFile:(NSString *)fileName;
// get handler function address
+ (NSUncaughtExceptionHandler*)getHandler;

+ (void)handleException:(NSException *)exception;

void UncaughtExceptionHandler(NSException *exception);

@end
