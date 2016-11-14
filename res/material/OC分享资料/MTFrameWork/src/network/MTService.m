//
//  MTService.m
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTService.h"
#import <stdarg.h>
#import "SynthesizeSingleton.h"
#import "MTConfigureEntity.h"
#import "NetworkConfigureParser.h"
#import "NetworkHelper.h"
#import "MTCacheManager.h"

//#define kServiceDefaultConfigureFile @"network_configure.xml"
//#define kMTServiceServerUrl @"http://api.m.mtime.cn"


@interface MTService ()

+ (NSString *)generateUrl:(NSString *)url args:(NSArray *)array;
+ (NSDictionary *)generateDictionary:(MTConfigureEntity *)entity args:(NSArray *)array;
- (void)sendMsg:(NSString *)uniqueKey withTarget:(NetworkTarget *)target args:(va_list)argList;

// find the configure entity according to the key
// return: the entity or nil if not found
- (MTConfigureEntity *)findEntity:(NSString *)key;

// initialize the configure dictionary from xml file
- (void)initConfigureDictionary;

// search the cache for key
// the key is assambled by uniqueKey_array[0]_array[1]...
- (id)getKeyForCache:(NSString *)uniqueKey args:(NSArray *)array;

// inform the target, that the network has been failed
// call this within MTService context, means that, the uniqueKey and/or params is wrong
+ (void)infoTargetFail:(NetworkTarget *)target;

// inform the target, that the network has been finished
// call this within MTService context, means that, the data is within cache
+ (void)infoTargetReady:(NetworkTarget *)target withData:(id)data;
+ (void)infoTargetProcessing:(NetworkTarget *)target;

@end


@implementation MTService

@synthesize configureFile = _fileName;
@synthesize serverName = _serverName;

SYNTHESIZE_SINGLETON_FOR_CLASS(MTService);

- (void)dealloc {
    [_data release];
    [_fileName release];
    [super dealloc];
}

- (bool)networkReachable {
    return [[NetworkHelper sharedInstance] networkReachable];
}

- (bool)reachableViaWWAN {
    return [[NetworkHelper sharedInstance] reachableViaWWAN];
}

- (bool)reachableViaWifi {
    return [[NetworkHelper sharedInstance] reachableViaWifi];
}

+ (void)setNetHeaderDelegate:(NSObject<MTNetworkDelegate> *)delegate {
    MTService *svc = [MTService sharedInstance];
    if ([delegate respondsToSelector:@selector(serverName)])
        svc.serverName = [delegate performSelector:@selector(serverName)];
//    svc.serverName = [delegate serverName];
    if ([delegate respondsToSelector:@selector(configureFileName)])
        svc.configureFile = [delegate performSelector:@selector(configureFileName)];
    NetworkHelper *helper = [NetworkHelper sharedInstance];
    helper.netDelegate = delegate;
}

+ (NSString *)get:(NSString *)uniqueKey withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target {
    NSMutableString *params = [[NSMutableString new] autorelease];
    NSMutableArray *keys = [NSMutableArray arrayWithArray:[dic allKeys]];
    [keys sortUsingSelector:@selector(compare:)];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:[keys count]];
    for (NSString *key in keys) {
        [params appendFormat:@"%@=%@", key, [dic objectForKey:key]];
        [params appendFormat:@"&"];
        [values addObject:[dic objectForKey:key]];
    }
    if ([keys count] > 0)
        [params deleteCharactersInRange:NSMakeRange([params length] - 1, 1)];
    
    NSString *str = nil;
    MTService *svc = [MTService sharedInstance];
    MTConfigureEntity *entity = [svc findEntity:uniqueKey];
    if (nil == entity) {
        [MTService infoTargetFail:target];
        return str;
    }
    
    NSString *url = nil;
    if ([params length] > 0)
        url = [NSString stringWithFormat:@"%@%@?%@", svc.serverName, entity.url, params];
    else
        url = [NSString stringWithFormat:@"%@%@", svc.serverName, entity.url];
    
    // check the cache for the data
    NSString *key = [svc getKeyForCache:uniqueKey args:values];
    id data = [MTCacheManager getItem:key];
    if (nil != data) {
        [MTService infoTargetReady:target withData:data];
        return url;
    }
    
    // assemble the info structure and finish network request
    NetworkHelperInfo *info = [[NetworkHelperInfo new] autorelease];
    info.cacheKey = key;
    info.cacheSeconds = entity.cacheSeconds;
    info.resultType = entity.resultType;
    info.url = url;
    [MTService infoTargetProcessing:target];
    [NetworkHelper get:info withTarget:target];
    return url;
}

+ (NSString *)post:(NSString *)uniqueKey withData:(NSDictionary *)dic withTarget:(NetworkTarget *)target {
    NSMutableArray *keys = [NSMutableArray arrayWithArray:[dic allKeys]];
    [keys sortUsingSelector:@selector(compare:)];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:[keys count]];
    for (NSString *key in keys) {
        [values addObject:[dic objectForKey:key]];
    }
    
    MTService *svc = [MTService sharedInstance];
    MTConfigureEntity *entity = [svc findEntity:uniqueKey];
    if (nil == entity) {
        [MTService infoTargetFail:target];
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", svc.serverName, entity.url];
    
    // check the cache for the data
    NSString *key = [svc getKeyForCache:uniqueKey args:values];
    id data = [MTCacheManager getItem:key];
    if (nil != data) {
        [MTService infoTargetReady:target withData:data];
        return url;
    }
    
    // assemble the info structure and finish network request
    NetworkHelperInfo *info = [[NetworkHelperInfo new] autorelease];
    info.cacheKey = key;
    info.cacheSeconds = entity.cacheSeconds;
    info.resultType = entity.resultType;
    info.url = url;
    [NetworkHelper post:info withData:dic withTarget:target];
    return url;
}

+ (void)sendMsg:(NSString *)uniqueKey withTarget:(NetworkTarget *)target,... {
    MTService *service = [MTService sharedInstance];
    va_list argList;
    va_start(argList, target);
    [service sendMsg:uniqueKey withTarget:target args:argList]; 
    va_end(argList);
}

+ (void)cancelRequestWithCaller:(id)controller {
    [NetworkHelper cancelRequestWithTarget:controller];
}

+ (NSDate *)serverTime {
    return [NetworkHelper serverTime];
}

- (void)sendMsg:(NSString *)uniqueKey withTarget:(NetworkTarget *)target args:(va_list)argList {
    MTConfigureEntity *entity = [self findEntity:uniqueKey];
    if (nil == entity) {
        [MTService infoTargetFail:target];
        return;
    }
    
    // generate the arguments array
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    NSString  *arg = nil;
    while ((arg = va_arg(argList, NSString *)) != nil) {
        NSLog(@"%@", arg);
        [array addObject:arg];
    }
    
    // check the cache for the data
    NSString *key = [self getKeyForCache:uniqueKey args:array];
    id data = [MTCacheManager getItem:key];
    if (nil != data) {
        [MTService infoTargetReady:target withData:data];
        return;
    }
    
    // assemble the info structure and finish network request
    NetworkHelperInfo *info = [NetworkHelperInfo new];
    info.cacheKey = key;
    info.cacheSeconds = entity.cacheSeconds;
    info.resultType = entity.resultType;
    [MTService infoTargetProcessing:target];
    if ([entity isGetMethod]) {
        NSString *url = [MTService generateUrl:entity.url args:array];
        info.url = url;
        [NetworkHelper get:info withTarget:target];
    }
    else {
        NSDictionary *dic = [MTService generateDictionary:entity args:array];
        info.url = entity.url;
        [NetworkHelper post:info withData:dic withTarget:target];
    } 
    [info release];
}

- (MTConfigureEntity *)findEntity:(NSString *)key {
    [self initConfigureDictionary];
    if (nil == _data)
        return nil;
    return [_data objectForKey:key];
}

// initialize the configure dictionary from xml file
- (void)initConfigureDictionary {
    if (nil != _data)
        return;
    if (nil == self.configureFile)
        return;
    _data = [[NetworkConfigureParser parse:self.configureFile] retain];
}

+ (void)infoTargetReady:(NetworkTarget *)target withData:(id)data {
    if (nil != target.target && nil != target.readySelector)
        [target.target performSelectorOnMainThread:target.readySelector withObject:data waitUntilDone:NO]; 
}

+ (void)infoTargetProcessing:(NetworkTarget *)target {
    if (nil != target.target && nil != target.processingSelector)
        [target.target performSelectorOnMainThread:target.processingSelector withObject:nil waitUntilDone:NO];
}

+ (void)infoTargetFail:(NetworkTarget *)target {
    if (nil != target.target && nil != target.failedSelector)
        [target.target performSelectorOnMainThread:target.failedSelector withObject:nil waitUntilDone:NO];
}

+ (NSString *)generateUrl:(NSString *)url args:(NSArray *)array {
    NSMutableString *str = [NSMutableString stringWithString:url];
    for (NSString *arg in array) {
        NSRange range = [str rangeOfString:@"%@"];
        [str replaceOccurrencesOfString:@"%@" withString:arg options:NSStringEncodingConversionAllowLossy range:range];
    }
    return str;
}

+ (NSDictionary *)generateDictionary:(MTConfigureEntity *)entity args:(NSArray *)array {
    NSArray *keys = entity.params;
    NSUInteger index = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    while (index < [array count] && index < [keys count]) {
        NSLog(@"value: %@; for Key: %@\n", [array objectAtIndex:index], [keys objectAtIndex:index]);
        [dic setObject:[array objectAtIndex:index] forKey:[keys objectAtIndex:index]];
        ++index;
    }
    return dic;
}

- (id)getKeyForCache:(NSString *)uniqueKey args:(NSArray *)array {
    
    return [NSString stringWithFormat:@"%@_%@", uniqueKey, [array componentsJoinedByString:@"_"]];
}

+ (BOOL)readCookies {
    return [NetworkHelper readCookies];
}

+ (void)clearCookies {
    [NetworkHelper clearCookies];
}

+ (void)setCookieFileName:(NSString *)fileName {
    [NetworkHelper setCookieFileName:fileName];
}

+ (BOOL)hasCookies {
    return [NetworkHelper hasCookies];
}

+ (BOOL)hasLogedin {
    return [NetworkHelper hasCookies];
}

@end
