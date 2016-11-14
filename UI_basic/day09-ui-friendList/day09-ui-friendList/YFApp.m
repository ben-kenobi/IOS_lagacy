
//
//  YFApp.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFApp.h"

@implementation YFApp

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)appWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
