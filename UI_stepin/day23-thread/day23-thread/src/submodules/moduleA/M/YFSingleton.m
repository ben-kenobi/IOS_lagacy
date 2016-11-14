
//
//  YFSingleton.m
//  day23-thread
//
//  Created by apple on 15/10/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSingleton.h"

@implementation YFSingleton


+(instancetype)singleton{
    static YFSingleton *obj;
    static long l;
    dispatch_once(&l, ^{
        obj=[[YFSingleton alloc] init];
    });
    return obj;
}


+(instancetype)singleton2{
    static YFSingleton *obj;
    @synchronized(self){
        if(!obj){
            obj=[[YFSingleton alloc] init];
        }
    }
    return obj;
}

+(instancetype)singleton3{
    static YFSingleton *obj;
    if(!obj){
        @synchronized(self){
            if(!obj){
                obj=[[YFSingleton alloc] init];
            }
        }
    }
    
    return obj;
}
@end
