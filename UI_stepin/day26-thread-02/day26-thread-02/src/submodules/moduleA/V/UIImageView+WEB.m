//
//  UIImageView+WEB.m
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIImageView+WEB.h"
#import "objc/runtime.h"
#import "YFDispatcher02.h"

static const char * key="adrkey";

@implementation UIImageView (WEB)
-(NSString *)adr{
    return objc_getAssociatedObject(self, key);
}

-(void)setAdr:(NSString *)adr {
    objc_setAssociatedObject(self, key, adr, OBJC_ASSOCIATION_COPY);
}
-(void)asynDL:(NSString *)str def:(UIImage *)defimg{
    if([str isEqualToString:self.adr])
        return ;
    
    [[YFDispatcher02 share] cancelOper:self.adr];
    self.adr=str;
    [[YFDispatcher02 share] asynDLImg:str onComp:^(UIImage *img)  {
        self.image=img;
        self.adr=nil;
    } def:defimg];
}

@end
