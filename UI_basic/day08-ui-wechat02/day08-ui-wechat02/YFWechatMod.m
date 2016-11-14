//
//  YFWechatMod.m
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatMod.h"

@implementation YFWechatMod
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modWithDict:(NSDictionary *)dict lastTime:(NSString *)lastTime{
    YFWechatMod *mod=[[self alloc] initWithDict:dict];
    mod.hideTime=[mod.time isEqualToString:lastTime];
    return mod;
}
@end
