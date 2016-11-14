//
//  Company.m
//  day08-ui-notification
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "Company.h"

@implementation Company

+(instancetype)comWithName:(NSString *)name{
    Company *obj=[[self alloc] init];
    obj.name=name;
    return obj;
}

@end
