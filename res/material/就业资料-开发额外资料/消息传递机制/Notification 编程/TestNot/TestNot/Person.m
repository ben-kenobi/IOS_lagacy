//
//  Person.m
//  TestNot
//
//  Created by 赵繁 on 15/12/16.
//  Copyright © 2015年 赵繁. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"TEST_NOTIFICATION" object:nil];
    }
    
    return self;
}

- (void)test {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
