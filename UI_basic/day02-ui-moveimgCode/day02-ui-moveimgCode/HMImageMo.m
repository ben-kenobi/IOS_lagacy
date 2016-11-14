//
//  HMImageMo.m
//  day02-ui-moveimgCode
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMImageMo.h"

@implementation HMImageMo

-(id)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        self.img=dict[@"img"];
        self.comment =dict[@"comment"];
    }
    return self;
}
+(id)imageMoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
