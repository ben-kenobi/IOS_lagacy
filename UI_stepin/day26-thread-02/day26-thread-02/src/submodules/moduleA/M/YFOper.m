//
//  YFOper.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFOper.h"

@implementation YFOper

-(void)start{

    [super start];
    
}

+(instancetype)operWithAdr:(NSString *)adr onComp:(void (^)(UIImage *img))onComp{
    YFOper *obj=[[self alloc] init];
    [obj setAdr:adr];
    [obj setOnComp:onComp];
    return obj;
}

-(void)main{
    @autoreleasepool {
        [NSThread sleepForTimeInterval:.5];
        UIImage *img=imgFromF(iRes(@"sound_Effect@2x.png"));
        if(self.onComp)
            self.onComp(img);
    }
}

@end
