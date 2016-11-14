//
//  MTMessageManager.h
//  IOSDemo
//
//  Created by Lines on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTMessageManager : NSObject

+ (void)registerObject:(id)object forMessage:(NSString *)messageName;
+ (void)unregisterObject:(id)object forMessage:(NSString *)messageName;
+ (void)unregisterObjectForAllMessage:(id)object;

+ (void)postMessage:(NSString *)messageName withObject:(id)params;

@end
