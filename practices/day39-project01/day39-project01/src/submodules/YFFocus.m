
//
//  YFFocus.m
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFFocus.h"

@implementation YFFocus

- (NSString *)description
{
    return [NSString stringWithFormat:@"YFFocus{@\"title\":%@,@\"cover\":%@,@\"link\":%@}", self.title,self.cover
            ,self.link];
}

@end
