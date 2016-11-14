//
//  MTJson.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-10.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "MTJson.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"

@implementation MTJson


+ (NSDictionary *)dictionrayFromString:(NSString *)jsonStr {
    return [jsonStr JSONValue];
}

+ (NSString *)jsonFromObject:(NSObject *)object {
    return [object JSONRepresentation];
}

@end
