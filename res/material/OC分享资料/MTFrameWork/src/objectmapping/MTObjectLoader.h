//
//  MTObjectLoader.h
//  IOSDemo
//
//  Created by Lines on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTObjectMapping;

@interface MTObjectLoader : NSObject

+ (id)loadObjectWithClassName:(NSString *)className andData:(id)primitiveData;

+ (NSDictionary *)dictionaryFromMapping:(MTObjectMapping *)mapping andObject:(id)object;

@end
