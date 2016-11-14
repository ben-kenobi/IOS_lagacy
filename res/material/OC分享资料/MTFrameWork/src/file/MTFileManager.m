//
//  MTFileManager.m
//  IOSDemo
//
//  Created by Lines on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTFileManager.h"

#define MTFileManagerCacheManagerDirectory @"cacheManager"
#define MTFileManagerExceptionDirectory @"exception"

@implementation MTFileManager

SYNTHESIZE_SINGLETON_FOR_CLASS(MTFileManager)

+ (NSString *)documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    return docPath;
}

+ (BOOL)mkdir:(NSString *)dirPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([self fileExists:dirPath] == NO)
        return [mgr createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return YES;
}

+ (void)writeDictionary:(NSDictionary *)dic toPath:(NSString *)path {
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:path] == NO)
        [mgr createFileAtPath:path contents:nil attributes:nil];
    [dic writeToFile:path atomically:YES];
}

+ (void)removeFile:(NSString *)filePath {
    if ([self fileExists:filePath])
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)fileExists:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (void)appendString:(NSString *)str toFile:(NSString *)filePath {
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [fileHandler seekToEndOfFile];
    [fileHandler writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler closeFile];
}

//! 获取Cache的目录
+ (NSString *)getAppCachePath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString*) getAppImgPath {
    NSString * cacheRoot = [MTFileManager getAppCachePath];
    NSString *path = [cacheRoot stringByAppendingPathComponent:@"imageCache"];
    if (![MTFileManager fileExists:path])
        [MTFileManager mkdir:path];
    return path;
}

@end












