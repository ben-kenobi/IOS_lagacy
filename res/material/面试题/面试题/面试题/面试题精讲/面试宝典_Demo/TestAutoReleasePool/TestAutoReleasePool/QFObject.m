//
//  QFObject.m
//  TestAutoReleasePool
//
//  Created by qianfeng on 14-6-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFObject.h"
#import "QFAutoReleasePool.h"
@implementation QFObject

-(id)autorelease
{
    if(pool == nil)
    {
        pool = [[QFAutoReleasePool alloc] init];
        pool->arrayObjects_ = [[NSMutableArray alloc] init];
    }
    [pool->arrayObjects_ addObject:self];
    
    [self release];
    
    return self;
}

@end
