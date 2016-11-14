//
//  MTNetworkManager.h
//  Net
//
//  Created by Lines on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASINetworkQueue;
@class MTNetRequest;

@interface MTNetworkManager : NSObject
{
    ASINetworkQueue  *networkQueue;
    NSDate *_currentServerDate; // the date from the server, returned from request header
}
@property (nonatomic, retain) ASINetworkQueue *networkQueue;
@property (nonatomic, retain) NSDate *serverDate;

+ (MTNetworkManager *)sharedInstance;

+ (BOOL)addRequest:(MTNetRequest *)request;

+ (void)cancelOperationWithTarget:(id)target;

/**
 * cancel all requests in the queue
 */
- (void)cancelConnections;

// get the corresponding server time from this request
// call this in net request call back, to get the server time in the net request
+ (NSDate *)serverTime;

+ (BOOL)readCookies;
+ (void)clearCookies;
+ (void)setCookieFileName:(NSString *)fileName;
+ (BOOL)hasCookies;

@end
