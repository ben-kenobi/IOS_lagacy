//
//  NetUtil.m
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "NetUtil.h"



@implementation NetUtil

+ (instancetype)manager {
    NetUtil *man= [[[self class] alloc] initWithBaseURL:nil];
    [man setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    return man;
}
+(void)request:(BOOL)get url:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *, NSURLResponse *, NSError *))callback{
    NetUtil *man=[NetUtil manager];
    [man.securityPolicy setAllowInvalidCertificates:YES];
    
    NSURLSessionDataTask *dataTask = [man dataTaskWithHTTPMethod:get?@"GET":@"POST" URLString:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];

    [dataTask resume];
}



+(NSString *)fullUrl:(NSString *)url{
    if ([url hasPrefix:@"http://"]||[url hasPrefix:@"https://"]) {
        return url;
    }
    return iFormatStr(@"%@%@",iBaseURL,url);
}

+(NSString *)paramlize:(NSDictionary *)param{
    NSMutableString *mstr=[NSMutableString string];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mstr appendFormat:@"%@=%@&",key,obj];
    }];
    [mstr deleteCharactersInRange:(NSRange){mstr.length-1,1}];
    return mstr;
}

@end
