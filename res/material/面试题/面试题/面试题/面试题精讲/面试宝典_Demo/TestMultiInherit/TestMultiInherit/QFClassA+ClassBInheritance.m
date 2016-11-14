//
//  QFClassA+ClassBInheritance.m
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <objc/runtime.h>
#import "QFClassA+ClassBInheritance.h"
#import "QFClassB.h"
static char const * const ClassBInstanceKey = "ClassBInstanceKey";


@implementation QFClassA (ClassBInheritance)
@dynamic classBInstance;
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if([self respondsToSelector:[anInvocation selector]]){
        [anInvocation invokeWithTarget:self];
    }else{
        if (self.classBInstance == nil) {
            self.classBInstance = [[QFClassB alloc] init];
            [self.classBInstance release];
        }
        [anInvocation invokeWithTarget:self.classBInstance];
        
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [QFClassB instanceMethodSignatureForSelector:selector];
    }
    return signature;
}

-(BOOL)conformsToProtocol:(Protocol *)aProtocol{
    if([QFClassB conformsToProtocol:aProtocol] || [super conformsToProtocol:aProtocol]){
        return YES;
    }
    return NO;
}

- (QFClassB *)classBInstance {
    return objc_getAssociatedObject(self, ClassBInstanceKey);
}

- (void)setClassBInstance:(QFClassB *)newClassBInstance {
    objc_setAssociatedObject(self, ClassBInstanceKey, newClassBInstance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
