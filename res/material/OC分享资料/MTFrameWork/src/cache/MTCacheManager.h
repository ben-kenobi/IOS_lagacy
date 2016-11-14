//
//  MTCacheManager.h
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/**
 cache 检查机制：1、用定时来清理cache，写文件。
 2、cache item 写文件，可以直接用key
 3、对上层隐藏读写缓存文件机制
 */
#import <Foundation/Foundation.h>

@class MTCacheItem;

@interface MTCacheManager : NSObject
{
    NSMutableDictionary *_data;
    NSMutableArray *_identifierArray;
    NSUInteger _maxSize; // maximum cached size, if the cached size > _maxSize, some will be cached into files, default size: 10000
    NSUInteger _totalSize;
}

// shared instance, singleton
+ (MTCacheManager*)sharedInstance;

#pragma mark common interfaces
// add a cacheitem - item into cache manager
// this item will be saved to file system, if the fileName isn't empty
// identifier: the unique identifier to load the identifier, duplicated
+ (void)addItem:(id)item forKey:(NSString *)identifier withExpireTime:(NSUInteger)seconds;
// get given item by identifier from cache
// return: the item pointer or nil, if there is no such item
+ (id)getItem:(id)identifier;
// remove item which is accessed by identifier from cache
+ (void)removeItem:(NSString *)identifier;

#pragma mark - read & write methods
+ (void)setMaximumCacheSize:(NSUInteger)size;
// save all items into file system;
// call this in proper place, when you want to save the cached items!!!
+ (void)saveCachedItems;
@end
