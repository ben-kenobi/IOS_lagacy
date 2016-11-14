//
//  QFObjectMRC.m
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFObjectMRC.h"

@implementation QFObjectMRC


-(void)setNumber:(NSNumber *)number
{
    if(number_ != number)
    {
        [number_ release];
        number_ = [number retain];
    }
}

-(NSNumber *)number
{
    return number_;
}

-(void)dealloc
{
    [number_ release];
     number_ = nil;
    
    [super dealloc];
}

@end
