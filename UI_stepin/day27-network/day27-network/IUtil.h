//
//  IUtil.h
//  day27-network
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LoginNoti @"LoginNoti"
#define LogoutNoti @"LogoutNoti"
#define usernamekey @"usernamekey"
#define pwdkey @"pwdkey"


@interface IUtil : NSObject

+(void)broadcast:(NSString *)mes info:(NSDictionary *)info;
+(float)systemVersion;


+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename;
+(NSURLResponse *)synResponseByURL:(NSURL *)url;

+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;


+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;


@end
