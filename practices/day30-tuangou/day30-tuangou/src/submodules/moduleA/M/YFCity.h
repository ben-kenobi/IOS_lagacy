//
//  YFCity.h
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFCity : NSObject
/** 城市名字 */
@property (nonatomic, copy) NSString *name;
/** 城市名字的拼音 */
@property (nonatomic, copy) NSString *pinYin;
/** 城市名字的拼音声母 */
@property (nonatomic, copy) NSString *pinYinHead;
/** 区域(存放的都是MTRegion模型) */
@property (nonatomic, strong) NSArray *regions;
@end
