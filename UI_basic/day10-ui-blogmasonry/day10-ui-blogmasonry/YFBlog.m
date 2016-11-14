

//
//  YFBlog.m
//  day10-ui-blogautolayout2
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlog.h"

@implementation YFBlog


+(instancetype)blogWithDict:(NSDictionary *)dict{
    YFBlog *blog=[[self alloc] init];
    [blog setValuesForKeysWithDictionary:dict];
    return blog;
}

@end
