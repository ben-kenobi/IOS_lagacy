//
//  YFMTUtil.m
//  day30-tuangou
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMTUtil.h"
#import "DPAPI.h"
@implementation YFMTUtil

+(void)dpget:(NSString *)url dict:(NSDictionary *)dict cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
     NSString* urlString = [DPRequest serializeURL:[NSString stringWithFormat:@"http://api.dianping.com/%@",url] params:dict];
    [IUtil get:iURL(urlString) cache:cache callBack:callback];
}

@end
