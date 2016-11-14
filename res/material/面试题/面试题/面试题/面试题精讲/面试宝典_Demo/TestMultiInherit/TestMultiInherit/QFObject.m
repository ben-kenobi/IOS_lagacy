//
//  QFObject.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFObject.h"

@implementation QFObject

-(id)init
{
    self = [super init];
    
    if(self)
    {
        self->qfPublicValue_  = 1000;
        self->qfProtectValue_ = @"qfProtectValue_";
        self->qfPrivateValue_ = @"qfPrivateValue_";
        self->qfPackageValue_ = @"qfPackageValue_";
    }
    return self;
    
}

#pragma mark - QFProtocol
-(void)QFDescription
{
    NSLog(@"this is Protocol QFObject description");
}

 

-(void)dealloc
{
    self->qfProtectValue_ = nil;
    self->qfPrivateValue_ = nil;
    self->qfPackageValue_ = nil;
    
    [super dealloc];
}

@end
