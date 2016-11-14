//
//  NetworkTarget.m
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetworkTarget.h"

@implementation NetworkTarget

@synthesize readySelector = _dataReady;
@synthesize processingSelector = _dataProcessing;
@synthesize failedSelector = _dataFailed;
@synthesize target = _target;

+ (NetworkTarget *) initWithTarget:(id)target 
{
    NetworkTarget *data = [NetworkTarget new];
    data.target = target;
    return [data autorelease];   
}

- (id)init {
    self = [super init];
    if (self) {
        _dataReady = @selector(onCmdLoadFinished:);
        // remove default processing callback
//        _dataProcessing = @selector(onCmdStartLoad);
        _dataFailed = @selector(onCmdLoadFail:);
    }
    return self;
}
@end
