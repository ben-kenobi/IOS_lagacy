//
//  MTObjectLoader.m
//  IOSDemo
//
//  Created by Lines on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTObjectLoader.h"
#import "MTObjectMapping.h"
#import "MTObjectAttribute.h"
#import "MTLogging.h"

@interface MTObjectLoader ()

+ (NSArray *)arrayFromMapping:(MTObjectMapping *)mapping andObject:(NSArray *)array;
+ (NSArray *)loadArrayFromClass:(Class)mapping andArray:(NSArray *)array;
@end

@implementation MTObjectLoader

+ (id)loadObjectWithClassName:(NSString *)className andData:(id)primitiveData {
    if (nil == className|| [className length] <= 0 || nil == primitiveData)
        return nil;
    id result = [[NSClassFromString(className) new] autorelease];
    MTObjectMapping *mapping = nil;
    if ([result respondsToSelector:@selector(objectMapping)]) {
        mapping = [result performSelector:@selector(objectMapping)];
    }
    else {
        LogError(@"loadObject Error: no such class %@", className);
    }
    if (nil != mapping) {
        if ([primitiveData isKindOfClass:[NSDictionary class]])
            result =  [self assignObject:result mapping:mapping dictionary:primitiveData];
        else
            result = [self loadArrayFromClass:NSClassFromString(className) andArray:primitiveData];
    }
    return result;
}

+ (id)loadObjectWithClassName:(NSString *)className andDictionary:(NSDictionary *)dic {
    id result = [[NSClassFromString(className) new] autorelease];
    MTObjectMapping *mapping = nil;
    if ([result respondsToSelector:@selector(objectMapping)])
        mapping = [result performSelector:@selector(objectMapping)];
    if (nil == mapping)
        return result;
    [self assignObject:result mapping:mapping dictionary:dic];
    return result;
}

+ (id)assignObject:(id)object mapping:(MTObjectMapping *)mapping dictionary:(NSDictionary *)dic {
    for (MTObjectAttribute *attribute in mapping.mappings) {
        id value = [dic objectForKey:attribute.sourceKeyPath];
        // simple value type, just assign
        if (nil == attribute.recursiveClass) {
            [object setValue:value forKey:attribute.destPathKeyPath];
            continue;
        }
        
        // custom type, CustomType *p; comes here,
        // generate the custom type
        if ([value isKindOfClass:[NSDictionary class]]) {
            id result = [[attribute.objectClass new] autorelease];
            MTObjectMapping *rMap = nil;
            if ([result respondsToSelector:@selector(objectMapping)])
                rMap = [result performSelector:@selector(objectMapping)];
            [self assignObject:result mapping:rMap dictionary:value];
            [object setValue:result forKey:attribute.destPathKeyPath];
            continue;
        }
        
        // array or custom type, comes here
        // is NOT array, continue
        if (![value isKindOfClass:[NSArray class]])
            continue;
        
        NSArray *array = [self loadArrayFromClass:attribute.recursiveClass andArray:value];
        if (array != nil)
        [object setValue:array forKey:attribute.destPathKeyPath];
    }
    
    return object;
}

+ (NSArray *)loadArrayFromClass:(Class)objectClass andArray:(NSArray *)array {
    if ([array count] <= 0)
        return array;
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];

    id item = [objectClass new];
    MTObjectMapping *mapping = nil;
    if ([item respondsToSelector:@selector(objectMapping)])
        mapping = [item performSelector:@selector(objectMapping)];
    [item release];
    if (nil == mapping)
        return result;
    
    for (id element in array) {
        id item = [objectClass new];
        [self assignObject:item mapping:mapping dictionary:element];
        [result addObject:item];
    }
    return result;
}

// TODO: finish the dictionary mapping!!
+ (NSDictionary *)dictionaryFromMapping:(MTObjectMapping *)mapping andObject:(id)object {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (MTObjectAttribute *attribute in mapping.mappings) {
        id value = [object valueForKey:attribute.destPathKeyPath];
        if (nil != attribute.recursiveClass) { // array of custom classes
            MTObjectMapping *mapping = nil;
            if ([value respondsToSelector:@selector(objectMapping)])
                mapping = [value performSelector:@selector(objectMapping)];
            if (nil == mapping)
                continue;
            NSArray *array = [self arrayFromMapping:mapping andObject:value];
            if ([array count] <= 0)
                continue;
            [dic setObject:array forKey:attribute.sourceKeyPath];
            continue;
        }
        
        if (nil == value)
            continue;
        [dic setObject:value forKey:attribute.sourceKeyPath];
    }
    return [dic autorelease];
}

+ (NSArray *)arrayFromMapping:(MTObjectMapping *)mapping andObject:(NSArray *)array {
    if ([array count] <= 0)
        return nil;
    NSMutableArray *rarray = [[NSMutableArray alloc] init];
    for (id element in array) {
        NSDictionary *eleDic = [self dictionaryFromMapping:mapping andObject:element];
        [rarray addObject:eleDic];
    }
    return [rarray autorelease];
}

@end
