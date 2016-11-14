//
//  YFFris.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFris.h"
#import "YFFri.h"
@implementation YFFris

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *ary=[NSMutableArray array];
        for(NSDictionary *dict in self.friends){
            [ary addObject:[YFFri friWithDict:dict]];
        }
        self.friends=ary;
        self.open=NO;
    }
    return self;
}

+(instancetype)frisWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
