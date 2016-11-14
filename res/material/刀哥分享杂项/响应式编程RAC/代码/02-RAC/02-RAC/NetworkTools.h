//
//  NetworkTools.h
//  02-RAC
//
//  Created by Romeo on 15/8/31.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef enum : NSUInteger {
    GET,
    POST
} RequestMethod;

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;
- (RACSignal *)request:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters;

@end
