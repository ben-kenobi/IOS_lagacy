//
//  YFWechatF.m
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatF.h"
#import "YFWechatMod.h"

@implementation YFWechatF


+(instancetype)fWithMod:(YFWechatMod *)mod{
    return [[self alloc] initWithMod:mod];
}

-(instancetype)initWithMod:(YFWechatMod *)mod{
    if(self=[super init]){
        self.mod=mod;
    }
    return self;
}

-(void)setMod:(YFWechatMod *)mod{
    _mod=mod;
    [self updateF];
}
-(void) updateF{
    CGFloat wid=[[UIScreen mainScreen] bounds].size.width,
    pad=10,iconH=60,timeH=0;
    if(_mod.showTime){
        timeH=20;
        _timeF=(CGRect){0,0,wid,timeH};
    }
    
    CGSize size=[_mod.text boundingRectWithSize:(CGSize){wid/2,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    size.height+=30;
    size.width+=40;
    
    if(_mod.type==ChatTYpe_O){
        _iconF=(CGRect){pad,timeH+pad,iconH,iconH};
        _textF=(CGRect){pad*2+iconH,timeH+pad,size};
    }else{
        _iconF=(CGRect){wid-pad-iconH,timeH+pad,iconH,iconH};
        _textF=(CGRect){wid-pad*2-iconH-size.width,timeH+pad,size};
    }
    
    
    
    
    
    CGFloat y1=CGRectGetMaxY(_textF),
    y2=CGRectGetMaxY(_iconF);
    _height=y1>y2?y1:y2;
    
    
    
}


@end
