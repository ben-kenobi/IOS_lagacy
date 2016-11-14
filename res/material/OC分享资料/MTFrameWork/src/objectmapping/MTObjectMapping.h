//
//  MTObjectMapping.h
//  IOSDemo
//
//  Created by Lines on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTObjectMapping : NSObject
{
    Class _objectClass;
    NSMutableArray* _mappings;
//    NSString* _rootKeyPath;
    BOOL _setDefaultValueForMissingAttributes;
//    BOOL _performKeyValueValidation;
    NSFormatter *_dateFormater;
}
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, retain) NSMutableArray *mappings;
@property (nonatomic, getter = shouldSetDefaultVAlueForMissingAttributes) BOOL setDefaultVAlueForMissingAttributes;
@property (nonatomic, retain) NSFormatter *dateFormater;

+ (MTObjectMapping *)mappingForClass:(Class)className;
+ (MTObjectMapping *)mappingForClassName:(NSString *)classNameStr;

// set relationship between srckKeypath to destAttribute
// srcKeyPath is the name of Json key
// destAttribute is the name of entity instance variable
- (void)mapKeyPath:(NSString *)srcKeyPath toAttribute:(NSString *)destAttribute withClass:(Class)attributeClass;
// same as upper function, but map between NSArray to array
// the content of NSArray should be custom entity, which is mapped by mapping
// mapping, the object mapping ralation ship for the elements of NSArray
- (void)mapKeyPath:(NSString *)srcKeyPath toAttribute:(NSString *)destAttribute withMapping:(Class)mappingClass;

// return the inverse mapping, used to serialize object
//- (MTObjectMapping *)inverseMapping;

@end
