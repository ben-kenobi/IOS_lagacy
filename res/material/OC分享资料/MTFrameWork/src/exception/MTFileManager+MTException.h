//
//  MTFileManager+MTException.h
//  MTFrameWork
//
//  Created by Lines on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTFileManager.h"

@interface MTFileManager (MTException)

/**
 * get the exception path
 */
+ (NSString *)exceptionPath;

/**
 * get the full path to the file in exeption path
 */
+ (NSString *)exceptionPathWithFile:(NSString *)fileName;

@end

