//
//  MTBaseRequest.m
//  Net
//
//  Created by Lines on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTNetRequest.h"
#import "MTNetworkManager.h"
#import "NetworkTarget.h"
#import "MTObjectLoader.h"
#import "NSString+SBJSON.h"
#import "MTCacheManager.h"

#define kNetRequestTimeoutSeconds 10
#define kNetRequestRetryTimes 1

@implementation MTNetRequest

@synthesize target = _target;
@synthesize sequenceID = _sequenceID;
@synthesize identifier = _requestIdentifier;
@synthesize targetObjectClassName = _targetObjectClassName;
@synthesize cacheKey = _cacheKey;
@synthesize cacheSeconds = _cacheSeconds;

- (id)init {
    self = [super init];
    if (self) {
        timeOutSeconds = kNetRequestTimeoutSeconds;
        numberOfTimesToRetryOnTimeout = kNetRequestRetryTimes;
    }
    return self;
}

- (void)dealloc {
    [_target release];
    [_requestIdentifier release];
    [_targetObjectClassName release];
    [super dealloc];
}

- (void)setDicData:(NSDictionary *)dic {  
	if (dic != nil) {
        NSArray *keys = [dic allKeys];
		for (id key in keys) {
            NSString *value = [dic objectForKey:key];
            [self setPostValue:value forKey:key];
		}
	}
    else {
        [self setPostValue:nil forKey:nil];
    }
}

- (NSString *)validateResponse
{
    NSInteger statusCode = self.responseStatusCode;
    NSString *errorMessage = nil;
    
    switch (statusCode) 
    {
        case 200:
        case 201:
        {
            break;
        }
            
        case 302:
        case 401:
        {
            // In the case of FFCRM, bad login API requests receive a 302,
            // with a redirection body taking to the login form
            errorMessage = @"Unauthorized";
            break;
        }
            
        case 404:
        {
            errorMessage = @"The specified path cannot be found (404)";
            break;
        }
            
        case 500:
        {
            errorMessage = @"The server experienced an error (500)";
            break;
        }
            
        default:
        {
            errorMessage = [NSString stringWithFormat:@"The communication with the server failed with error %d", statusCode];
            break;
        }
    }
    
    return errorMessage;
}

- (void)processResponse {
    [self performSelectorInBackground:@selector(parseData) withObject:nil];
}

- (void)processFailure {
    if (nil != self.target)
        [self.target.target performSelectorOnMainThread:self.target.failedSelector
                                             withObject:nil
                                          waitUntilDone:NO];
}

- (id)result {
    return [self responseString];
}

- (void)go {
    [MTNetworkManager addRequest:self];
}

- (void)parseData {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSString *str = [self responseString];
    NSLog (@"Json: %@", str);
    id jsonData = [str JSONValue];
    id result = [MTObjectLoader loadObjectWithClassName:self.targetObjectClassName andData:jsonData];
    if (nil != result)
        [MTCacheManager addItem:result forKey:self.cacheKey withExpireTime:self.cacheSeconds];
    if (nil != self.target)
        [self.target.target performSelectorOnMainThread:self.target.readySelector
                                             withObject:result
                                          waitUntilDone:YES];
    [pool drain];
}

@end
