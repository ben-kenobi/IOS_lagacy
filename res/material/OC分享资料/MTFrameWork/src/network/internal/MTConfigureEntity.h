//
//  MTConfigureEntity.h
//  MTimeMovie
//
//  Created by Lines on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// a structure used for network configuration xml file
// each MTConfigureEntity stands for an entry in configure file, that's xml file is an dictionary with each value = MTConfigureEntity
@interface MTConfigureEntity : NSObject
{
    NSString *_url; // url string, the param will be "%@", for convenience in "get", no "%@" in "post"
    NSArray *_params; // string array, each string stand for a param name in "post", or only an occupition in "get"
    NSString *_resultType; // result's class name
    NSString *_method; // get or post
    NSUInteger _cacheSeconds; // how long the data should be cachec, unit: seconds
}

@property (nonatomic, retain) NSString *url; 
@property (nonatomic, retain) NSArray *params; 
@property (nonatomic, retain) NSString *resultType;
@property (nonatomic, retain) NSString *method;
@property (nonatomic, assign) NSUInteger cacheSeconds;

// whether or not method == "get"
- (BOOL)isGetMethod;

@end
