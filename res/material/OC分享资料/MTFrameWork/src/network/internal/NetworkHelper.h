//
//  NetworkHelper.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-8-1.
//  Copyright (c) 2012年 mtime.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTNetRequest.h"
#import "MTNetworkDelegate.h"
#import "Reachability.h"

@class NetworkTarget;

@class MTConfigureEntity;

/**
 * a simple structure, used for parameter passing for NetworkHelper
 */
@interface NetworkHelperInfo : NSObject {
    NSString *_url;
    NSString *_cacheKey; // key used for save result into item
    NSString *_resultType; // result' class name
    NSUInteger _cacheSeconds; // seconds that the result should exists in cache
}
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *cacheKey;
@property (nonatomic, retain) NSString *resultType;
@property (nonatomic, assign) NSUInteger cacheSeconds;

@end


/**
 * network helper
 * provide network get/post methods
 */
@interface NetworkHelper : NSObject {
    NSObject<MTNetworkDelegate> *_netDelegate;
    Reachability *_reachability;
}
@property (nonatomic, assign)  NSObject<MTNetworkDelegate> *netDelegate;
@property (nonatomic, retain) Reachability *reachabilityForHost;

+ (NetworkHelper *)sharedInstance;

// network status
- (bool)networkReachable;
- (bool)reachableViaWWAN;
- (bool)reachableViaWifi;
- (void)setupReachability;

// network get method,
// url, the url string
// target: controller's pointer & callbacks
+ (void)get:(NetworkHelperInfo *)info withTarget:(NetworkTarget *)target;

// network post method, all the dic's content will be used as post data
// url, the url string
// dic, post data, the key will be the post data's key
// target: controller's pointer & callbacks
+ (void)post:(NetworkHelperInfo *)info withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target;

// cancel the network request with controller = target
// target: the controller's pointer
+ (void)cancelRequestWithTarget:(id)controller;

/**
 * cancel all requests in the queue
 */
+ (void)cancelConnections;

// get the corresponding server time from this request
// call this in net request call back, to get the server time in the net request
+ (NSDate *)serverTime;

// convert server time from string
+ (NSDate *)convertServerTime:(NSString *)dateStr;

+ (BOOL)readCookies;
+ (void)clearCookies;
+ (void)setCookieFileName:(NSString *)fileName;
+ (BOOL)hasCookies;

@end
