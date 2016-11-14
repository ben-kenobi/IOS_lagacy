//
//  YFDealTool.h
//  day30-tuangou
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFDeal.h"
@interface YFDealTool : NSObject
/**
 *  返回第page页的收藏团购数据:page从1开始
 */
+ (NSArray *)collectDeals:(int)page;
+ (int)collectDealsCount;
/**
 *  收藏一个团购
 */
+ (void)addCollectDeal:(TFDeal *)deal;
/**
 *  取消收藏一个团购
 */
+ (void)removeCollectDeal:(TFDeal *)deal;
/**
 *  团购是否收藏
 */
+ (BOOL)isCollected:(TFDeal *)deal;
@end
