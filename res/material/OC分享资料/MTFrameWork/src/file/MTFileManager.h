//
//  MTFileManager.h
//  IOSDemo
//
//  Created by Lines on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface MTFileManager : NSFileManager

+ (MTFileManager *)sharedInstance;

#pragma mark common interfaces
// get the document path
// that should be ...
+ (NSString *)documentPath;
// create a directory at dirPath
// if the directory has been already existed, this function won't re-create it, just return YES
+ (BOOL)mkdir:(NSString *)dirPath;

+ (void)appendString:(NSString *)str toFile:(NSString *)filePath;

// write dictionary into file: path
// NOTE: path is absolute path
+ (void)writeDictionary:(NSDictionary *)dic toPath:(NSString *)path;

// get the file content as dictionary
// NOTE: the file name is NOT absolute path
+ (void)removeFile:(NSString *)filePath;
+ (BOOL)fileExists:(NSString *)path;

+ (NSString*) getAppImgPath;

@end
