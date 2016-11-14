//
//  NSData+SDDataCache.h
//  SDCycleScrollView
//
//  Created by aier on 15-3-30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (SDDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;
+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com