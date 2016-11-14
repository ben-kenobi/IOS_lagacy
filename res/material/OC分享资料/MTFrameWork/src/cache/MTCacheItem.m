//
//  MTCacheItem.m
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTCacheItem.h"
#import "MTObjectMapping.h"
#import "MTObjectLoader.h"

#define MTCacheItemExpiredDate  @"expiredDate"
#define MTCacheItemClassName    @"className"
#define MTCacheItemContent      @"content"

@implementation MTCacheItem

@synthesize expiredDate = _expiredDate;
@synthesize dirty = _dirty;

+ (MTObjectMapping *)objectMapping {
    MTObjectMapping *mapping = [MTObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPath:MTCacheItemExpiredDate toAttribute:@"expiredDate" withClass:[NSDate class]];
    [mapping mapKeyPath:MTCacheItemClassName toAttribute:@"_dataClassName" withClass:[NSString class]];
    return mapping;
}

- (NSDictionary *)saveToDictionary {
    MTObjectMapping *mapping = [NSClassFromString(_dataClassName) objectMapping];
    NSDictionary *objectDic = [MTObjectLoader dictionaryFromMapping:mapping andObject:_cachedData];
    MTObjectMapping *selfmapping = [MTCacheItem objectMapping];
    NSDictionary *dic = [MTObjectLoader dictionaryFromMapping:selfmapping andObject:self];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [result setObject:objectDic forKey:MTCacheItemContent];
    return result;
}

+ (id)initFromDictionary:(NSDictionary *)dic {
    MTCacheItem *item = [MTObjectLoader loadObjectWithClassName:NSStringFromClass([MTCacheItem class]) andData:dic];
    id content = [MTObjectLoader loadObjectWithClassName:[dic objectForKey:MTCacheItemClassName]
                                                 andData:[dic objectForKey:MTCacheItemContent]];
    [item setCacheData:content];
    return [item autorelease];
}

#pragma mark - 
- (id)init {
    self = [super init];
    if (self) {
        _expiredDate = [[NSDate dateWithTimeIntervalSince1970:0] retain];
        _cachedData = nil;
        _dirty = NO;
    }
    return self;
}

- (void)dealloc {
    [_expiredDate release];
    [_cachedData release];
    [_dataClassName release];
    [super dealloc];
}

- (void)setCacheData:(id)cacheData {
    [_cachedData release];
    [_dataClassName release];
    _cachedData = [cacheData retain];
    _dataClassName = [NSStringFromClass([_cachedData class]) retain];
    _dirty = YES;
}

- (id)cacheData {
    return _cachedData;
}

- (BOOL)expired {
    NSDate *date = [NSDate date];
    if ([date compare:self.expiredDate] == NSOrderedDescending)
        return YES;
    return NO;
}
- (void)setExpiredSeconds:(NSInteger)seconds {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:seconds];
    self.expiredDate = date;
}

- (NSInteger)expiredSeconds {
    NSDate *date = [NSDate date];
    NSInteger seconds = [self.expiredDate timeIntervalSinceDate:date];
    return seconds;
}

@end
