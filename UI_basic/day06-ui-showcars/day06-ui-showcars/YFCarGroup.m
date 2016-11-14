//
//  YFCarGroup.m
//  day06-ui-showcars
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCarGroup.h"
#import "YFCarMod.h"

@implementation YFCarGroup


-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
        NSArray *ary=self.cars;
        NSMutableArray *mary =[NSMutableArray array];
        for(NSDictionary *di in ary){
            [mary addObject:[YFCarMod modWithDict:di]];
        }
        self.cars=mary;
    }
    return self;
}
+(instancetype)modWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
