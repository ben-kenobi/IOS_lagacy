//
//  NetUtil.m
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "NetUtil.h"
#import "AFNetworking.h"
@implementation NetUtil


+(void)post:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
     [man.securityPolicy setAllowInvalidCertificates:YES];
    [man POST:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];
}
+(void)get:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
     [man.securityPolicy setAllowInvalidCertificates:YES];
    [man GET:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];
    
}
+(NSString *)fullUrl:(NSString *)url{
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
