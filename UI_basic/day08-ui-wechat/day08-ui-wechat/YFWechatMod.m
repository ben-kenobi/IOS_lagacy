
//
//  YFWechatMod.m
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatMod.h"

@implementation YFWechatMod

+(instancetype)modWithDict:(NSDictionary *)dict lastTime:(NSString  *)lastTime{
    YFWechatMod *mod=[[self alloc] initWithDict:dict];
    mod.showTime=![lastTime isEqualToString:mod.time];
    return mod;
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
