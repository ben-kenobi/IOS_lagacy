//
//  YFFriendF.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFriendF.h"
#import "YFFriend.h"
@implementation YFFriendF



-(void)updateF{
    CGFloat wid=[UIScreen mainScreen].bounds.size.width,
    iconH=30,pad=10;
    _iconF=(CGRect){pad,pad,iconH,iconH};
    CGFloat labw=wid-iconH-pad*2-pad;
    _nameF=(CGRect){pad*2+iconH,pad,labw,20};
    CGSize introsize=[_fri.intro boundingRectWithSize:CGSizeMake(labw, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _introF=(CGRect){pad*2+iconH,CGRectGetMaxY(_nameF)+pad,introsize};
    
    CGFloat height1,height2;
    height1=CGRectGetMaxY(_iconF);
    height2=CGRectGetMaxY(_introF);
    _heigth=(height2>height1?height2:height1)+pad;
}

-(void)setFri:(YFFriend *)fri{
    _fri=fri;
    [self updateF];
}


-(instancetype)initWithFri:(YFFriend *)fri{
    if(self=[super init]){
        self.fri=fri;
    }
    return self;
}

+(instancetype)fWithFri:(YFFriend *)fri{
    return [[self alloc] initWithFri:fri];
}

@end
