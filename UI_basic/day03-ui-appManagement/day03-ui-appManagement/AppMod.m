//
//  AppMod.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppMod.h"

@implementation AppMod

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        self.img=[UIImage imageNamed:dict[@"img"]];
        self.title=dict[@"title"];
    }
    return self;
}
+(instancetype)appModWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
