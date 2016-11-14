//
//  MTObjectAttribute.h
//  IOSDemo
//
//  Created by Lines on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTObjectMapping;

@interface MTObjectAttribute : NSObject
{
    NSString *_sourceKeyPath;
    NSString *_destKeyPath;
    Class _recursiveClass;
    Class _objectClassClass;
}
@property (nonatomic, retain) NSString *sourceKeyPath;
@property (nonatomic, retain) NSString *destPathKeyPath;
@property (nonatomic, assign) Class recursiveClass;
@property (nonatomic, assign) Class objectClass;

@end
