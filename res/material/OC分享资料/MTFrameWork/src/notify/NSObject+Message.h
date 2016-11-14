//
//  NSObject+Message.h
//  IOSDemo
//
//  Created by Lines on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Message)

// message interaction interfaces
// register self for special message by messageName
- (void)registerMessage:(NSString *)messageName;
// unregister self from formerly registered special message by messageName
- (void)unregisterMessage:(NSString *)messageName;
// quick interface to cancel all message registeration for self
- (void)unregisterAllMessage;

// called when a former registered message by messageName occured
- (void)postMessage:(NSString *)messageName;
// add objects
- (void)postMessage:(NSString *)messageName withObject:(id)params;
// deal with message by messageName to others
// add passing object
- (void)dealWithMessage:(NSString *)messageName withObject:(id)params;

@end
