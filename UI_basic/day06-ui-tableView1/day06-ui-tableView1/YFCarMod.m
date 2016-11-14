//
//  YFCarMod.m
//  day06-ui-tableView1
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCarMod.h"

@implementation YFCarMod

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)modWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
