//
//  MTBaseRequest.h
//  Net
//
//  Created by Lines on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ASIFormDataRequest.h"

@class NetworkTarget;

@interface MTNetRequest : ASIFormDataRequest
{
    NetworkTarget *_target;
    NSUInteger _sequenceID;
    NSString *_requestIdentifier;
    NSString *_targetObjectClassName;
    NSString *_cacheKey;
    NSUInteger _cacheSeconds;
}

@property (nonatomic, retain) NetworkTarget *target;
@property (nonatomic) NSUInteger sequenceID;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *targetObjectClassName;
@property (nonatomic, retain) NSString *cacheKey;
@property (nonatomic, assign) NSUInteger cacheSeconds;

- (NSString *)validateResponse;
- (void)processResponse;
- (void)processFailure;
- (NSString *)result;

// kick off the net request
- (void)go;

// set post data for request
// for "get", just set dic = nil, this will set get's header
// for "set", the contents of dic will be appended to request body
- (void)setDicData:(NSDictionary *)dic;

@end
