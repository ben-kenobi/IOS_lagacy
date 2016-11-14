//
//  YFBlog.m
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlog.h"

@implementation YFBlog

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)blogWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
