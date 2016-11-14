//
//  MTService.h
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkTarget.h"
#import "MTNetworkDelegate.h"

@interface MTService : NSObject
{
    NSDictionary *_data;
    NSString *_fileName;
    NSString *_serverName;
}

@property (nonatomic, retain) NSString *configureFile;
@property (nonatomic, retain) NSString *serverName;

+ (MTService *) sharedInstance;

+ (void)setNetHeaderDelegate:(NSObject<MTNetworkDelegate> *)delegate;

// network status
- (bool)networkReachable;
- (bool)reachableViaWWAN;
- (bool)reachableViaWifi;

// send request with "get" method
// url: @"Mobile/SignIn.api", the server http url will be added. "http://api.m.mtime.com/"
// dic: dictionary that will be appended into url
// target: call backs
+ (NSString *)get:(NSString *)url withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target;

// send request with "get" method
// url: @"Mobile/SignIn.api", the server http url will be added. "http://api.m.mtime.com/"
// dic: dictionary that will be added into request header
// target: call backs
+ (NSString *)post:(NSString *)url withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target;

// cancel the network request with controller pointer
// controller: the controller's pointer
+ (void)cancelRequestWithCaller:(id)controller;

// get the corresponding server time from this request
// call this in net request call back, to get the server time in the net request
+ (NSDate *)serverTime;

// cookies interfaces
+ (BOOL)readCookies;
+ (void)clearCookies;
+ (void)setCookieFileName:(NSString *)fileName;
+ (BOOL)hasCookies;
+ (BOOL)hasLogedin;

@end
