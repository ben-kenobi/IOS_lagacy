//
//  NSString+Ex.m
//  day26-thread-02
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSString+Ex.h"

@implementation NSString (Ex)


-(instancetype)strByAppendToCachePath{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:self.lastPathComponent];
}

-(instancetype)strByAppendToDocPath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:self.lastPathComponent];
}
-(instancetype)strByAppendToTempPath{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
