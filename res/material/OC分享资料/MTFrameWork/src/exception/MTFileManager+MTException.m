//
//  MTExceptionFileHelper.m
//  IOSDemo
//
//  Created by Lines on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTFileManager+MTException.h"

#define MTExceptionFileHelperCacheManagerDirectory @"cacheManager"
#define MTExceptionFileHelperExceptionDirectory @"exception"

@implementation MTFileManager (MTException)



+ (NSString *)exceptionPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:MTExceptionFileHelperExceptionDirectory];
    return path;
}

+ (NSString *)exceptionPathWithFile:(NSString *)fileName {
    NSString *dir = [self exceptionPath];
    return [dir stringByAppendingPathComponent:fileName];
}
@end
