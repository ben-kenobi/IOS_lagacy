//
//  MTFileManager+MTCache.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-7-9.
//  Copyright (c) 2012年 MTime.com. All rights reserved.
//

#import "MTFileManager.h"

@interface MTFileManager (MTCache)

// get the directory path for cache manager, which should be unique
+ (NSString *)cacheManagerPath;

// get full path with fileName in cache manager's cache path
+ (NSString *)pathInCacheDir:(NSString *)fileName;

// get all the file names in cache manager's cache path
// return: array with file names only, not the absolute path
+ (NSArray *)allFileNamesInCacheDirectory;

+ (NSDictionary *)cachedDictionaryFromFile:(NSString *)fileName;

@end
