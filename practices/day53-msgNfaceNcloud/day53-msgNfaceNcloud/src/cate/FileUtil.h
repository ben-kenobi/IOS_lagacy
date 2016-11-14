//
//  FileUtil.h
//  day35-yfcityhunt
//
//  Created by apple on 15/11/20.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+(long long)fileSizeAtPath:(NSString *)path;

+(NSString *)cachePath;
+(NSString *)docPath;
+(NSString *)tempPath;
+(void)clearFileAtPath:(NSString *)path;
+(NSString *)formatedFileSize:(long long)size;
+(NSString *)formatedFileSize2:(long long)size;
@end
