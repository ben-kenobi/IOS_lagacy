//
//  MTJson.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-10.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTJson : NSObject

+ (NSDictionary *)dictionrayFromString:(NSString *)jsonStr;

+ (NSString *)jsonFromObject:(NSObject *)object;

@end
