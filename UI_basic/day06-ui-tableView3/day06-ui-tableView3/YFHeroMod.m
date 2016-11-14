//
//  YFHeroMod.m
//  day06-ui-tableView3
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHeroMod.h"

@implementation YFHeroMod

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(id)copyWithZone:(NSZone *)zone{
    YFHeroMod *mod=[[YFHeroMod alloc] init];
    mod.name=self.name;
    mod.intro=self.intro;
    mod.icon=self.icon;
    return mod;
}

@end
