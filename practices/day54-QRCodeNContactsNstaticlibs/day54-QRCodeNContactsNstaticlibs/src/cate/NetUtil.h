//
//  NetUtil.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetUtil : NSObject

+(void)post:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
    

+(void)get:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
    

@end
