//
//  NetUtil.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NetUtil : AFHTTPSessionManager

+(void)request:(BOOL)get url:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
 
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end
