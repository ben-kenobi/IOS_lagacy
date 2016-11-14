
//
//  YFFriListF.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFriListF.h"
#import "YFFriendList.h"

@implementation YFFriListF


-(void)updateF{
    CGFloat wid=[UIScreen mainScreen].bounds.size.width,
    iconH=40,pad=10;
    _nameF=(CGRect){0,0,wid,iconH};
    _onlineF=(CGRect){0,0,wid-pad,iconH};
    _height=iconH;
}

-(void)setFrilist:(YFFriendList *)frilist{
    _frilist=frilist;
    [self updateF];
}

-(instancetype)initWithFrilist:(YFFriendList *)frilist{
    if(self=[super init]){
        self.frilist=frilist;
    }
    return self;
}

+(instancetype)fWithFrilist:(YFFriendList *)frilist{
    return [[self alloc] initWithFrilist:frilist];
}

@end
