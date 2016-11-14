//
//  MTFileManager+MTCache.
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-7-9.
//  Copyright (c) 2012年 MTime.com. All rights reserved.
//

#import "MTFileManager+MTCache.h"

#define MTFileManagerCacheManagerDirectory @"cacheManager"
#define MTFileManagerExceptionDirectory @"exception"

@implementation MTFileManager (MTCache)

+ (NSString *)cacheManagerPath {
    NSString *dir = [self documentPath];
    NSString *path = [dir stringByAppendingPathComponent:MTFileManagerCacheManagerDirectory];
    [self mkdir:path];
    return path;
}

+ (NSString *)pathInCacheDir:(NSString *)fileName {
    NSString *path = [self cacheManagerPath];
    NSString *dir = [path stringByAppendingPathComponent:fileName];
    return dir;
}

+ (NSArray *)allFileNamesInCacheDirectory {
    NSString *path = [self cacheManagerPath];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return array;
}

+ (NSDictionary *)cachedDictionaryFromFile:(NSString *)fileName {
    NSString *path = [self pathInCacheDir:fileName];
    NSDictionary *dic = nil;
    if ([self fileExists:path]) {
        dic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dic;
}
                    
                      
@end
