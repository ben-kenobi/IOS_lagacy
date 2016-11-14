//
//  HMGussMod.m
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMGussMod.h"

@implementation HMGussMod

+(instancetype)modWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
