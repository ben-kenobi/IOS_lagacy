//
//  NSObject+Message.m
//  IOSDemo
//
//  Created by Lines on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Message.h"
#import "MTMessageManager.h"

@implementation NSObject(Message)

#pragma mark - message processing

- (void)registerMessage:(NSString *)messageName {
    [MTMessageManager registerObject:self forMessage:messageName];
}

- (void)unregisterMessage:(NSString *)messageName {
    [MTMessageManager unregisterObject:self forMessage:messageName];
}

- (void)unregisterAllMessage {
    [MTMessageManager unregisterObjectForAllMessage:self];
}

- (void)postMessage:(NSString *)messageName {
    [MTMessageManager postMessage:messageName];
}

- (void)postMessage:(NSString *)messageName withObject:(id)params {
    [MTMessageManager postMessage:messageName withObject:params];
}

- (void)dealWithMessage:(NSString *)messageName withObject:(id)params {
}

- (void)dealNotification:(NSNotification *)notification {
    [self dealWithMessage:notification.name withObject:notification.object];
}

@end
