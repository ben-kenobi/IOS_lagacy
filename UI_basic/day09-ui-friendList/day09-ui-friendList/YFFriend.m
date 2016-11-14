//
//  YFFriend.m
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFriend.h"

@implementation YFFriend
+(instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc]  initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}



@end
