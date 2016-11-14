//
//  NSObject+Ex.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSObject+Ex.h"

@implementation NSObject (Ex)


+(instancetype)setDict:(NSDictionary *)dict{
    return [IUtil setValues:dict forClz:self];
}


@end
