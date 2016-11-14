//
//  Person.m
//  03-谓词演练
//
//  Created by 刘凡 on 15/12/20.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ ~ %@ ~ %zd", _name, _title, _age];
}

@end
