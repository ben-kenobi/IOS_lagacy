//
//  MTMessageManager.m
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTMessageManager.h"

@implementation MTMessageManager

+ (void)registerObject:(id)object forMessage:(NSString *)messageName {
    [[NSNotificationCenter defaultCenter] addObserver:object selector:@selector(dealNotification:) name:messageName object:nil];
}

+ (void)unregisterObject:(id)object forMessage:(NSString *)messageName {
    [[NSNotificationCenter defaultCenter] removeObserver:object forKeyPath:messageName];
}

+ (void)unregisterObjectForAllMessage:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:object];
}

+ (void)postMessage:(NSString *)messageName withObject:(id)params {
    [[NSNotificationCenter defaultCenter] postNotificationName:messageName object:params];
}

@end
