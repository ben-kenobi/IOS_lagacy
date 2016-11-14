//
//  YFMetaTool.h
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YFCategory,TFDeal;
@interface YFMetaTool : NSObject

+(NSArray *)cities;
+(NSArray *)cityGroups;
+ (NSArray *)categories;
+ (YFCategory *)categoryWithDeal:(TFDeal *)deal;
+(NSArray *)sorts;

@end
