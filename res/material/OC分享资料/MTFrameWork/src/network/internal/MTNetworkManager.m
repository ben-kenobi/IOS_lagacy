//
//  MTNetworkManager.m
//  Net
//
//  Created by Lines on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTNetworkManager.h"
#import "ASINetworkQueue.h"
#import "SynthesizeSingleton.h"
#import "MTNetRequest.h"
#import "NetworkHelper.h"
#import "MTFileManager.h"
#import "NetworkTarget.h"

@interface MTNetworkManager()

- (void)cancelOperationFromQueue:(id)target;
@end

@implementation MTNetworkManager

@synthesize serverDate = _currentServerDate;
@synthesize networkQueue = _networkQueue;

SYNTHESIZE_SINGLETON_FOR_CLASS(MTNetworkManager)

#pragma mark - cookies

static NSArray *cookies;
static NSString *cookieFileName;

+ (NSDate *)serverTime {
    MTNetworkManager *mgr = [MTNetworkManager sharedInstance];
    return mgr.serverDate;
}

+ (BOOL)readCookies {   //载入本地cookies
    NSMutableArray *httpCookes = [[[NSMutableArray alloc]
                                   initWithContentsOfFile:cookieFileName] autorelease];
    if ([httpCookes count] > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
        for (NSDictionary *dic in httpCookes) {
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dic];
            [array addObject:cookie];
        }
        cookies = array;
        [ASIHTTPRequest setSessionCookies:array];
        return YES;
    }
    return NO;
}

+ (void)clearCookies {
    //清之前的cookies
    [ASIHTTPRequest clearSession];
    [cookies release];
    cookies = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cookieFileName]) {
        [fileManager removeItemAtPath:cookieFileName error:nil];
    }
}

+ (void)cacheCookies {
    // if cookies already cached, don't cache it more
    // if you want to cache current cookie, remove former one
    if ([cookies count] > 1)
        return;
    NSArray *sessionCookies = [ASIHTTPRequest sessionCookies];
    if ([sessionCookies count] > 0)
        cookies =  [sessionCookies retain];
    else
        cookies = nil;
    
    //缓存cookies
    if ([cookies count] > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
        for (NSHTTPCookie *item in cookies) {
            NSDictionary *dic = [item properties];
            [array addObject:dic];
        }
        [array writeToFile:cookieFileName atomically:NO];
    } 
}

+ (BOOL)hasCookies {
    if ([cookies count] > 0)
        return YES;
    return NO;
}

+ (void)setCookieFileName:(NSString *)fileName {
    cookieFileName = [[NSHomeDirectory() stringByAppendingPathComponent:fileName] retain];
}
#pragma mark - Init and Dealloc

- (id)init 
{
if (self = [super init]) {
    self.networkQueue = [[[ASINetworkQueue alloc] init] autorelease];
    self.networkQueue.shouldCancelAllRequestsOnFailure = NO;
    self.networkQueue.delegate = self;
    self.networkQueue.requestDidFinishSelector = @selector(requestDone:);
    self.networkQueue.requestDidFailSelector = @selector(requestWentWrong:);
    self.networkQueue.queueDidFinishSelector = @selector(queueFinished:);
    [self.networkQueue go];
}
return self;
}

- (void)dealloc {
    [_networkQueue release];
    [_currentServerDate release];
    [super dealloc];
}

#pragma mark - common interfaces

+ (void)cancelOperationWithTarget:(id)target {
    MTNetworkManager *mgr = [MTNetworkManager sharedInstance];
    [mgr cancelOperationFromQueue:target];
}

- (void)cancelOperationFromQueue:(id)target {
    NSArray *array = [self.networkQueue operations];
    for (MTNetRequest *op in array) {
        if (op.target.target == target)
            [op cancel];
    }
}

- (void)cancelConnections {
    [self.networkQueue cancelAllOperations]; 
}

+ (BOOL)addRequest:(MTNetRequest *)request{
    if (nil == request)
        return NO;
 
    //设置超时时间，和在超时时间内，重复请求的次数
    request.timeOutSeconds = 10;
    request.numberOfTimesToRetryOnTimeout = 1;
    
    // Authentication verification.
    NSMutableArray *ck = [NSMutableArray arrayWithArray:cookies];
    [request setRequestCookies:ck];
    
    // add the request to the queue
    MTNetworkManager *mgr = [MTNetworkManager sharedInstance];
    [mgr.networkQueue addOperation:request];
    return YES;
}

#pragma mark - ASINetworkQueue delegate methods

- (void)requestDone:(MTNetRequest *)request {
    NSString *errorMessage = [request validateResponse];
    NSLog(@"Request Error code: %@", errorMessage);
    // todo: seperate the network error & server error
    if (errorMessage == nil) {
        [self saveServerTime:request];
        [MTNetworkManager cacheCookies];
        [request processResponse];
    }
    else {
        self.serverDate = nil;
        [request processFailure];
    }
}

- (void)requestWentWrong:(MTNetRequest *)request {
    NSLog(@"network error: %@", [request responseString]);
    self.serverDate = nil;
    [request processFailure];
}

- (void)queueFinished:(ASINetworkQueue *)queue {
}

- (void)saveServerTime:(MTNetRequest *)request {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSDictionary *responseDic = request.responseHeaders;
    NSString *date = [responseDic objectForKey:@"Date"];
    NSDate *responeDate = [NetworkHelper convertServerTime:date];
    self.serverDate = responeDate;
    [pool drain];
}
@end
