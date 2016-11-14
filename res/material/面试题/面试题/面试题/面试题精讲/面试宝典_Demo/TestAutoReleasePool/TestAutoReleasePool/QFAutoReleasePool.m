//
//  QFAutoReleasePool.m
//  TestAutoReleasePool
//
//  Created by qianfeng on 14-6-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFAutoReleasePool.h"

@implementation QFAutoReleasePool

-(void)dealloc
{
    [arrayObjects_ removeAllObjects];
    [super dealloc];
}

@end
