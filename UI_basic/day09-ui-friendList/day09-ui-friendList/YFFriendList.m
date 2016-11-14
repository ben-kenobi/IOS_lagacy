//
//  YFFriendList.m
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFriendList.h"
#import "YFFriend.h"
#import "YFFriendF.h"

@implementation YFFriendList

+(instancetype)listWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *mary=[NSMutableArray array];
        for(NSDictionary  *dict in self.friends){
            [mary addObject:[YFFriendF fWithFri:[YFFriend friendWithDict:dict]]];
        }
        self.friends=mary;
        self.hide=YES;
    }
    return self;
        
}


@end
