//
//  MTConfigureEntity.m
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTConfigureEntity.h"

@implementation MTConfigureEntity

@synthesize url = _url; 
@synthesize params= _params; 
@synthesize resultType = _resultType;
@synthesize method = _method;
@synthesize cacheSeconds = _cacheSeconds;

- (void)dealloc {
    [_url release];
    [_params release];
    [_resultType release];
    [_method release];
    [super dealloc];
}

- (BOOL)isGetMethod {
    return [_method compare:@"get"] == NSOrderedSame;
}

@end
