//
//  YFTgF.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgF.h"
#import "YFTg.h"

@implementation YFTgF


-(instancetype)initWithTg:(YFTg *)tg wid:(CGFloat)wid{
    if(self=[super init]){
        self.wid=wid;
        self.tg=tg;
    }
    return self;
}

+(instancetype)tgfWithTg:(YFTg *)tg wid:(CGFloat)wid{
    return [[self alloc] initWithTg:tg wid:wid];
}


-(void)setTg:(YFTg *)tg{
    _tg=tg;
    [self updateF];
}

-(void)updateF{
    CGFloat padding=10,
    iconX=60;
    
    _iconF=(CGRect){padding,padding,iconX,iconX};
    
    CGSize titlesize=[_tg.title boundingRectWithSize:(CGSize){_wid-3*padding-iconX,(iconX-padding)/2} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _titleF=(CGRect){CGRectGetMaxX(_iconF)+padding,padding,titlesize};
    
    CGSize pricesize=[[NSString stringWithFormat:@"¥%@",_tg.price] boundingRectWithSize:CGSizeMake(_wid-4*padding-iconX/2, (iconX-padding)/2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    _priceF=(CGRect){CGRectGetMinX(_titleF),CGRectGetMaxY(_iconF)-pricesize.height,pricesize};
    
    CGSize countsize=[[NSString stringWithFormat:@"buyCount:%@",_tg.buyCount] boundingRectWithSize:CGSizeMake(_wid-CGRectGetMaxX(_priceF)-padding*2, (iconX-padding)/2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _buyCountF=(CGRect){_wid-padding-countsize.width,CGRectGetMaxY(_iconF)-countsize.height,countsize};
    
    _height=CGRectGetMaxY(_iconF)+padding*2;
    
    
}

@end
