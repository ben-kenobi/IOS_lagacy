//
//  QFClassA.h
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "QFObject.h"
#import "QFObject+MoreMethods.h"

@interface QFClassA : QFObject
{
    NSString *name_;
}

- (void)printOwnerProperties;
- (void)methodA;

@end
