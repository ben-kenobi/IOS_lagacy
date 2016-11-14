//
//  YFMTUtil.h
//  day30-tuangou
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFMTUtil : NSObject

+(void)dpget:(NSString *)url dict:(NSDictionary *)dict cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

@end
