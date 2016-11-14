//
//  NetworkHelper.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-8-1.
//  Copyright (c) 2012年 mtime.com. All rights reserved.
//

#import "NetworkHelper.h"
#import "MTNetworkManager.h"
#import "MTConfigureEntity.h"
#import "SynthesizeSingleton.h"
#import "NetworkTarget.h"

@implementation NetworkHelperInfo

@synthesize url = _url;
@synthesize cacheKey = _cacheKey;
@synthesize resultType = _resultType;
@synthesize cacheSeconds = _cacheSeconds;

- (id)init {
    self = [super init];
    if (self) {
        _cacheSeconds = 0;
    }
    return self;
}

- (void)dealloc {
    [_url release];
    [_cacheKey release];
    [_resultType release];
    [super dealloc];
}

@end

@implementation NetworkHelper

@synthesize netDelegate = _netDelegate;
@synthesize reachabilityForHost = _reachability;

SYNTHESIZE_SINGLETON_FOR_CLASS(NetworkHelper);

- (void)dealloc {
    [_reachability release];
    [super dealloc];
}

- (bool)networkReachable {
    return [self.reachabilityForHost isReachable];
}

- (bool)reachableViaWWAN {
    NetworkStatus status = [self.reachabilityForHost currentReachabilityStatus];
    return status | kReachableViaWWAN;
}

- (bool)reachableViaWifi {
    NetworkStatus status = [self.reachabilityForHost currentReachabilityStatus];
    return status | kReachableViaWiFi;
}

- (void)setupReachability {
    NSString *hostName = nil;
    if (nil != self.netDelegate && [self.netDelegate respondsToSelector:@selector(hostNameForReachability)]) {
        hostName = [self.netDelegate performSelector:@selector(hostNameForReachability)];
    }
    if (nil == self.reachabilityForHost) {
        if (nil == hostName) {
        self.reachabilityForHost = [Reachability reachabilityForInternetConnection];
        }
        else {
            self.reachabilityForHost = [Reachability reachabilityWithHostName:hostName];
        }
    }
}

+ (void)get:(NetworkHelperInfo *)info withTarget:(NetworkTarget *)target {
    [[self sharedInstance] setupReachability];
    if (![[self sharedInstance] networkReachable]) {
        if (nil != target.target && nil != target.failedSelector)
            [target.target performSelectorOnMainThread:target.failedSelector withObject:nil waitUntilDone:NO];
        return;
    }
    
    NSString *urlStr = info.url;
    MTNetRequest *request = [MTNetRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.target = target;
    request.cacheKey = info.cacheKey;
    request.cacheSeconds = info.cacheSeconds;
    request.targetObjectClassName = info.resultType;
    [request setDicData:nil];
    [self setReuqestPropertity:request withData:nil];
    [request setPostValue:nil forKey:nil];
    [request setRequestMethod:@"GET"];
    [request go];
}

+ (void)post:(NetworkHelperInfo *)info withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target {
    [[self sharedInstance] setupReachability];
    if (![[self sharedInstance] networkReachable]) {
        if (nil != target.target && nil != target.failedSelector)
            [target.target performSelectorOnMainThread:target.failedSelector withObject:nil waitUntilDone:NO];
        return;
    }
    
    NSString *urlStr =info.url;
    MTNetRequest *request = [MTNetRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.target = target;
    request.cacheKey = info.cacheKey;
    request.cacheSeconds = info.cacheSeconds;
    request.targetObjectClassName = info.resultType;
    [request setDicData:dic];
    [self setReuqestPropertity:request withData:dic];
    [request setRequestMethod:@"POST"];
    [request go];
}

+ (void)setReuqestPropertity:(MTNetRequest *)request withData:(NSDictionary *)dictionary {
    // set network request header
    NetworkHelper *helper = [NetworkHelper sharedInstance];
    if (nil != helper.netDelegate) {
        if ([helper.netDelegate respondsToSelector:@selector(requestHeader: andData:)]) {
            NSDictionary *dic = [helper.netDelegate performSelector:@selector(requestHeader: andData:) withObject:[request.url absoluteString] withObject:dictionary];
            NSArray *keys = [dic allKeys];
            for (NSString *key in keys)
                [request addRequestHeader:key value:[dic objectForKey:key]];
        }
        if ([helper.netDelegate respondsToSelector:@selector(timeoutSeconds)]) {
            NSNumber *seconds = [helper.netDelegate performSelector:@selector(timeoutSeconds)];
            request.timeOutSeconds = [seconds intValue];
        }
        if ([helper.netDelegate respondsToSelector:@selector(retryNumber)]) {
            NSNumber *retryNumber = [helper.netDelegate performSelector:@selector(retryNumber)];
            request.numberOfTimesToRetryOnTimeout = [retryNumber intValue];
        }
    }
}

+ (void)cancelRequestWithTarget:(id)target {
    [MTNetworkManager cancelOperationWithTarget:target];
}

+ (void)cancelConnections {
    [[MTNetworkManager sharedInstance] cancelConnections];
}

+ (NSDate *)serverTime {
    return [MTNetworkManager serverTime]; 
}

+ (NSDate *)convertServerTime:(NSString *)dateStr {
    NSDate *date = nil;
    NetworkHelper *helper = [NetworkHelper sharedInstance];
    if (nil != helper.netDelegate && [helper.netDelegate respondsToSelector:@selector(convertServerTime:)]) 
        date = [helper.netDelegate performSelector:@selector(convertServerTime:) withObject:dateStr];
    return date;
}

+ (BOOL)readCookies {
    return [MTNetworkManager readCookies];
}

+ (void)clearCookies {
    [MTNetworkManager clearCookies];
}

+ (void)setCookieFileName:(NSString *)fileName {
    [MTNetworkManager setCookieFileName:fileName];
}

+ (BOOL)hasCookies {
    return [MTNetworkManager hasCookies];
}

@end
