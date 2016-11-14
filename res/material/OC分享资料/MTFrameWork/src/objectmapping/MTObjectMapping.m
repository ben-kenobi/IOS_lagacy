//
//  MTObjectMapping.m
//  IOSDemo
//
//  Created by Lines on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTObjectMapping.h"
#import "MTObjectAttribute.h"

@interface MTObjectMapping ()


@end

@implementation MTObjectMapping

@synthesize objectClass = _objectClass;
@synthesize mappings = _mappings;
@synthesize setDefaultVAlueForMissingAttributes = _setDefaultValueForMissingAttributes;
@synthesize dateFormater = _dateFormater;

#pragma mark - class methods

+ (MTObjectMapping *)mappingForClass:(Class)className {
    MTObjectMapping *mapping = [MTObjectMapping new];
    mapping.objectClass = className;
    return [mapping autorelease];
}

+ (MTObjectMapping *)mappingForClassName:(NSString *)classNameStr {
    return [MTObjectMapping mappingForClass:NSClassFromString(classNameStr)];
}

#pragma mark - instance methods

- (id)init {
    self = [super init];
    if (self) {
        _mappings = [NSMutableArray new];
        self.setDefaultVAlueForMissingAttributes = YES;
    }
    return self;
}

- (void)dealloc {
    [_mappings release];
    [super dealloc];
}

- (void)mapKeyPath:(NSString *)srcKeyPath toAttribute:(NSString *)destAttribute  withClass:(Class)attributeClass{
    MTObjectAttribute *attribute = [MTObjectAttribute new];
    attribute.sourceKeyPath = srcKeyPath;
    attribute.destPathKeyPath = destAttribute;
    attribute.objectClass = attributeClass;
    [self.mappings addObject:attribute];
    [attribute release];
}

- (void)mapKeyPath:(NSString *)srcKeyPath toAttribute:(NSString *)destAttribute withMapping:(Class)mappingClass {
    MTObjectAttribute *attribute = [MTObjectAttribute new];
    attribute.sourceKeyPath = srcKeyPath;
    attribute.destPathKeyPath = destAttribute;
    attribute.recursiveClass = mappingClass;
    [self.mappings addObject:attribute];
    [attribute release];
}

@end
