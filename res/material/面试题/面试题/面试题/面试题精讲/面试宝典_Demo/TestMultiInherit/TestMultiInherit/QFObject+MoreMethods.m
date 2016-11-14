//
//  QFObject+MoreMethods.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFObject+MoreMethods.h"

@implementation QFObject (MoreMethods)

-(void)CategoryDescription
{
    NSLog(@"this is Category %@ description",[self class]);
}

@end
