//
//  YFWechatF.m
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatF.h"
#import "YFWechatMod.h"


@implementation YFWechatF

-(instancetype)initWithMod:(YFWechatMod *)mod{
    if(self = [super init]){
        self.mod=mod;
    }
    return self;
}

+(instancetype)fWithMod:(YFWechatMod *)mod{
    return [[self alloc] initWithMod:mod];
}

-(void)setMod:(YFWechatMod *)mod{
    _mod=mod;
    [self updateF];
}

-(void)updateF{
    CGFloat wid=[[UIScreen mainScreen]bounds].size.width,
    pad=8,iconH=60;
    if(!_mod.isHideTime)
        _timeF=(CGRect){0,0,wid,30};
    CGSize textsize=[_mod.text boundingRectWithSize:(CGSize){wid/2,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    textsize.width+=40;
    textsize.height+=30;
    CGFloat y1=CGRectGetMaxY(_timeF);
    if(_mod.type==WechatType_O){
        _iconF=(CGRect){pad,y1,iconH,iconH};
        _textF=(CGRect){CGRectGetMaxX(_iconF)+pad,y1,textsize};
    }else{
        _iconF=(CGRect){wid-pad-iconH,y1,iconH,iconH};
        _textF=(CGRect){CGRectGetMinX(_iconF)-pad-textsize.width,y1,textsize};
    }
    
    CGFloat height1,height2;
    height1=CGRectGetMaxY(_iconF);
    height2=CGRectGetMaxY(_textF);
    _height=(height2>height1?height2:height1)+pad;
        
    
}
@end
