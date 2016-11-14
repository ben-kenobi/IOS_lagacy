//
//  MTExceptionHandler.m
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTExceptionHandler.h"
#import "SynthesizeSingleton.h"
#import "MTFileManager+MTException.h"
#import "MTLogging.h"


//void UncaughtExceptionHandler(NSException *exception);
@interface MTExceptionHandler ()
+ (void)handleUncaughtException:(NSException *)exception;
- (void)handleException:(NSException *)exception;
- (void)handleUncaughtException:(NSException *)exception;
- (void)handleException:(NSException *)exception withFile:(NSString *)fileName;
@end

@implementation MTExceptionHandler

@synthesize uncaughtFile;
@synthesize caughtFile;

SYNTHESIZE_SINGLETON_FOR_CLASS(MTExceptionHandler)


+ (void)setExceptionHandler {
   NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler); 
}

+ (void)setExceptionFile:(NSString *)fileName {
    NSString *path = [MTFileManager exceptionPathWithFile:fileName];
    [self sharedInstance].caughtFile = path;
}

+ (void)setCaughtExceptionFile:(NSString *)fileName {

    NSString *path = [MTFileManager exceptionPathWithFile:fileName];

    //NSString *path = [MTExceptionFileHelper exceptionPathWithFile:fileName];
    [self sharedInstance].uncaughtFile = path; 
}

+ (NSUncaughtExceptionHandler*)getHandler {
    return NSGetUncaughtExceptionHandler();
}

+ (void)handleException:(NSException *)exception {
    [[self sharedInstance] handleException:exception];
}

+ (void)handleUncaughtException:(NSException *)exception {
    [[self sharedInstance] handleUncaughtException:exception];
}

- (void)handleException:(NSException *)exception {
    if (nil != self.caughtFile)
        [self handleException:exception withFile:self.caughtFile];
    else
        [self handleUncaughtException:exception];
}

- (void)handleUncaughtException:(NSException *)exception {
    [self handleException:exception withFile:self.uncaughtFile];     
}

- (void)handleException:(NSException *)exception withFile:(NSString *)fileName {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *err = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@", name,reason,[arr componentsJoinedByString:@"\n"]];
    //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
    //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
    //或者调用某个处理程序来处理这个信息
    // 有文件，就写文件，没有文件就打印日志
    if (nil != fileName) {

        [MTFileManager appendString:err toFile:fileName];

        //[MTExceptionFileHelper appendString:err toFile:fileName]; 
        return;
    }
    LogError(@"%@\n", err);
}

void UncaughtExceptionHandler(NSException *exception) {
    [MTExceptionHandler handleUncaughtException:exception];
}

@end
