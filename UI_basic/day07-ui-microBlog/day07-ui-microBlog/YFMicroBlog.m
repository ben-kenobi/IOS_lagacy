//
//  YFMicroBlog.m
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMicroBlog.h"

@implementation YFMicroBlog
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
