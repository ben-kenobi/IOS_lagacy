//
//  MTCacheManager.m
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTCacheManager.h"
#import <malloc/malloc.h>
#import "SynthesizeSingleton.h"
#import "MTCacheItem.h"
#import "MTObjectLoader.h"
#import "MTFileManager+MTCache.h"

#define MTCacheManagerClassName @"MTCacheManagerClassName"
#define MTCacheManagerIdentifier @"MTCacheManagerIdentifier"
#define MTCacheManagerContent @"MTCacheManagerContent"

#define MTCacheManagerMaximumSize 100000

@interface MTCacheManager()

+ (void)removeCachedFile:(NSString *)identifier;
- (void)setMaximumCacheSize:(NSUInteger)size;
- (void)saveAllToFiles;
- (void)addItemToCache:(id)item forKey:(NSString *)identifier withExpireTime:(NSUInteger)seconds;
- (id)getItemFromCache:(NSString *)identifier;
- (void)removeItemFromCache:(NSString *)identifier;

// read & write item into file, the corresponding item will be removed from memory
- (MTCacheItem *)loadItemFromFile:(NSString *)identifier;
- (void)cacheItemToFile:(NSString *)identifier;

- (void)updateItemPriority:(NSString *)identifier;
- (void)addMemorySize:(MTCacheItem *)item;
- (void)substractMemorySize:(MTCacheItem *)item;
- (void)handleMemorySize;

@end

@implementation MTCacheManager

SYNTHESIZE_SINGLETON_FOR_CLASS(MTCacheManager)

#pragma makr - public interfaces

+ (void)addItem:(id)item forKey:(NSString *)identifier withExpireTime:(NSUInteger)seconds {
    if (nil == item || nil == identifier || [identifier length] <= 0)
        return;
    [[MTCacheManager sharedInstance] addItemToCache:item forKey:identifier withExpireTime:seconds];
}

+ (void)removeItem:(NSString *)identifier {
    [[MTCacheManager sharedInstance] removeItemFromCache:identifier];
}

+ (id)getItem:(NSString *)identifier {
    return [[MTCacheManager sharedInstance] getItemFromCache:identifier];
}

+ (void)setMaximumCacheSize:(NSUInteger)size {
    [[MTCacheManager sharedInstance] setMaximumCacheSize:size];
}

+ (void)saveCachedItems {
    [[MTCacheManager sharedInstance] saveAllToFiles];
}

#pragma mark - memory
- (id)init {
    self = [super init];
    if (self) {
        _data = [[NSMutableDictionary alloc] init];
        NSArray *array = [MTFileManager allFileNamesInCacheDirectory];
        _identifierArray = [[NSMutableArray alloc] initWithArray:array];
        _maxSize = MTCacheManagerMaximumSize;
        _totalSize = 0;
    }
    return self;
}

- (void)dealloc {
    [_data release];
    [_identifierArray release];
    [super dealloc];
}

#pragma mark - internals

- (void)addItemToCache:(id)item forKey:(NSString *)identifier withExpireTime:(NSUInteger)seconds {
    MTCacheItem *content = [_data objectForKey:identifier];
    if (nil == content) {
        content = [[MTCacheItem new] autorelease];
        [content setExpiredSeconds:seconds];
        [content setCacheData:item];
        [self addMemorySize:content];
        [_data setObject:content forKey:identifier];
    }
    else {
        [content setExpiredSeconds:seconds];
        [self substractMemorySize:item];
        [content setCacheData:item]; 
        [self addMemorySize:item];
    }
    [self updateItemPriority:identifier];
    [self handleMemorySize];
}

- (id)getItemFromCache:(NSString *)identifier {
    MTCacheItem *item = [_data objectForKey:identifier];
    if (nil == item) // if the item is not in memory, search cached files
        item = [self loadItemFromFile:identifier];
    if (nil == item)
        return nil;
    if ([item expired]) {
        [self removeItemFromCache:identifier];
        return nil;
    }
    [self updateItemPriority:identifier];
    return [item cacheData];
}

- (void)removeItemFromCache:(NSString *)identifier {
    MTCacheItem *item = [_data objectForKey:identifier];
    if (item) {
        [self substractMemorySize:item];
        [_data removeObjectForKey:identifier];
    }
    [MTCacheManager removeCachedFile:identifier];
    [_identifierArray removeObject:identifier];
}


- (void)setMaximumCacheSize:(NSUInteger)size {
    _maxSize = size;
}

- (void)saveAllToFiles {
    NSArray *keys = [_data allKeys];
    for (NSString *key in keys) {
        [self cacheItemToFile:key];
    }
}

- (MTCacheItem *)loadItemFromFile:(NSString *)identifier {
    NSDictionary *dic = [MTFileManager cachedDictionaryFromFile:identifier];
    if ([dic count] <= 0)
        return nil;
    MTCacheItem *item = [MTCacheItem initFromDictionary:dic];
    if (nil == item || [item expired]) {
        [MTCacheManager removeCachedFile:identifier];
        return nil;
    }
    // add the loaded item into cache
    [self addItemToCache:item.cacheData forKey:identifier withExpireTime:[item expiredSeconds]];
    return item;
}

- (void)cacheItemToFile:(NSString *)identifier {
    MTCacheItem *item = [_data objectForKey:identifier];
    if (!item.dirty)
        return;
    NSDictionary *dic = [item saveToDictionary];
    NSString *path = [MTFileManager pathInCacheDir:identifier];
    [MTFileManager writeDictionary:dic toPath:path];
    [_data removeObjectForKey:identifier];
    [self substractMemorySize:item];
}

+ (void)removeCachedFile:(NSString *)identifier {
   NSString *path = [MTFileManager pathInCacheDir:identifier];
    [MTFileManager removeFile:path]; 
}

- (void)updateItemPriority:(NSString *)identifier {
    [_identifierArray removeObject:identifier];
    [_identifierArray insertObject:identifier atIndex:0];
}

- (void)addMemorySize:(MTCacheItem *)item {
    NSUInteger size = malloc_size(item);
    _totalSize += size;
}

- (void)substractMemorySize:(MTCacheItem *)item {
    NSUInteger size = malloc_size(item);
    _totalSize -= size;
}

- (void)handleMemorySize {
    NSUInteger index = [_identifierArray count] - 1;
    while (_totalSize >_maxSize) {
        MTCacheItem *item = [_data objectForKey:[_identifierArray objectAtIndex:index]];
        if (nil == item)
            continue;
        [self cacheItemToFile:[_identifierArray objectAtIndex:index]];
    }
}

@end
