//
//  QFClassB.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFClassB.h"

@interface QFClassB ()

@end

@implementation QFClassB

- (void)methodB
{
    NSLog(@"this is methodB");
}

- (void)dealloc
{
    NSLog(@"dealloc in %@",[self class]);
    [super dealloc];
} 

-(void)QFDescription
{
    NSLog(@"this is Protocol ClassB description");
}

@end
