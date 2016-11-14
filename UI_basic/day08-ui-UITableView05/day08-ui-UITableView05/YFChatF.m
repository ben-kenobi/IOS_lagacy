//
//  YFChatF.m
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFChatF.h"
#import "YFChatMod.h"

@implementation YFChatF

+(instancetype)charFWithMod:(YFChatMod *)mod wid:(CGFloat)wid{
    return [[self alloc] initWithMod:mod wid:wid];
}
-(instancetype)initWithMod:(YFChatMod *)mod wid:(CGFloat)wid{
    if(self=[super init]){
        self.wid=wid;
        self.mod=mod;
    }
    return self;
}

-(void)setMod:(YFChatMod *)mod{
    _mod=mod;
    [self updateF];
}

-(void)updateF{
    CGFloat padding=10,
    iconH=40,timeH=0;
    if(!_mod.isHideTime){
        timeH=20;
        _timeF=CGRectMake(0, 0, _wid, timeH);
    }
    CGSize textSize=[_mod.text boundingRectWithSize:CGSizeMake(_wid/2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    textSize.height=textSize.height+40;
    textSize.width=textSize.width+50;
    if(_mod.type==ChatType_O){
        _iconF=(CGRect) {padding,padding+timeH,iconH,iconH};
        _textF=(CGRect){CGRectGetMaxX(_iconF)+padding*2,padding+timeH+iconH/2,textSize};
    }else{
        _iconF=(CGRect){_wid-padding-iconH,padding+timeH,iconH,iconH};
        _textF=(CGRect){CGRectGetMinX(_iconF)-padding*2-textSize.width,padding+timeH+iconH/2,textSize};
    }
    _height=CGRectGetMaxY(_textF)+padding*3;
    
    
}

@end
