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
+(NSString *)getTimestamp;
+(void)broadcast:(NSString *)mes info:(NSDictionary *)info;
+(float)systemVersion;

+(NSArray *)prosWithClz:(Class)clz;
+(id)setValues:(NSDictionary *)dict forClz:(Class)clz;

+(NSArray *)aryWithClz:(Class)clz fromFile:(NSString *)file;


+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename;
+(NSURLResponse *)synResponseByURL:(NSURL *)url;

+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;


+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;


+(void)post:(NSURL *)url body:(NSString *)body callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
+(void)get:(NSURL *)url cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

@end
