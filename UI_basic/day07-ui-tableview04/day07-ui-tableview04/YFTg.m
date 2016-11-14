//
//  YFTg.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTg.h"

@implementation YFTg

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)tgWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


-(NSString *)description{
    return [NSString stringWithFormat:@"{title:%@,icon:%@,price:%@,buyCount:%@}",_title,_icon,_price,_buyCount];
}
@end
