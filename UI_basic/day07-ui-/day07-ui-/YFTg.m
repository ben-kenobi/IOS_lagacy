//
//  YFTg.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTg.h"

@implementation YFTg


+(instancetype)tgWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


-(id)copyWithZone:(NSZone *)zone{
    YFTg *obj=[[YFTg alloc] init];
    obj.icon=self.icon;
    obj.title=self.title;
    obj.price=self.price;
    obj.buyCount=self.buyCount;
    return obj;
}

@end
