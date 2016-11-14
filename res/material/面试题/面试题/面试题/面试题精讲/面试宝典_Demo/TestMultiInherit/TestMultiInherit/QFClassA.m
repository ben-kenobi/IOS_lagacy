//
//  QFClassA.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFClassA.h"

@implementation QFClassA

-(id)init
{
    self = [super init];
    
    if(self)
    {
        self->name_ = @"QFClassA Property";
    }
    return self;
    
}


- (void)printOwnerProperties
{
    
    //super
    NSLog(@"super qfPublicValue_  %d",self->qfPublicValue_);
    NSLog(@"super qfProtectValue_ %@",self->qfProtectValue_);
    NSLog(@"super qfPackageValue_ %@",self->qfPackageValue_);
    
    //提示出错
    //NSLog(@"qfPrivateValue_ %@",self->qfPrivateValue_);
    
    //self
    NSLog(@"self name_ %@",self->name_);
     
}
 
- (void)methodA
{
    NSLog(@"this is methodA");
}

#pragma mark - QFProtocol
-(void)QFDescription
{
    NSLog(@"this is Protocol ClassA description");
}



-(void)dealloc
{
    
    
    [super dealloc];
}

@end
