//
//  MTCacheItem.h
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTObjectMapping;

@interface MTCacheItem : NSObject
{
    NSDate *_expiredDate;
    id _cachedData;
    NSString *_dataClassName;
    BOOL _dirty;
}

@property (nonatomic, retain) NSDate *expiredDate;
@property (atomic) BOOL dirty;

// object mapping relationship for cache item
+ (MTObjectMapping *)objectMapping;

+ (id)initFromDictionary:(NSDictionary *)dic;
- (NSDictionary *)saveToDictionary;

- (void)setCacheData:(id)cacheData;
- (id)cacheData;
- (BOOL)expired;
- (void)setExpiredSeconds:(NSInteger)seconds;
- (NSInteger)expiredSeconds;

@end
