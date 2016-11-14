//
//  YFFri.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFri.h"

@implementation YFFri

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)friWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
