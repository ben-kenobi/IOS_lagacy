//
//  YFWechatCell.m
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatCell.h"
#import "YFWechatF.h"
#import "YFWechatMod.h"

@interface YFWechatCell ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UIButton *text;

@end

@implementation YFWechatCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}


-(void)setF:(YFWechatF *)f{
    _f=f;
    [self updateUI];
}
-(void)updateUI{
    self.time.frame=_f.timeF;
    self.time.text=_f.mod.time;
    
    self.icon.frame=_f.iconF;
    [self.text setTitle:_f.mod.text forState:UIControlStateNormal];
    self.text.frame=_f.textF;
    if(_f.mod.type==WechatType_O){
        self.icon.image=[UIImage imageNamed:@"other"];
        [self.text setBackgroundImage:[self resizableImg:[UIImage imageNamed:@"chat_recive_nor"]] forState:UIControlStateNormal];
        [self.text setBackgroundImage:[self resizableImg:[UIImage imageNamed:@"chat_recive_press_pic"]] forState:UIControlStateHighlighted];
    }else{
        self.icon.image=[UIImage imageNamed:@"me"];
        [self.text setBackgroundImage:[self resizableImg:[UIImage imageNamed:@"chat_send_nor"]] forState:UIControlStateNormal];
        [self.text setBackgroundImage:[self resizableImg:[UIImage imageNamed:@"chat_send_press_pic"]] forState:UIControlStateHighlighted];
    }
    
}

-(UIImage *)resizableImg:(UIImage *)img{
    CGFloat h=img.size.width/2,
    v=img.size.height/2;
   return  [img resizableImageWithCapInsets:(UIEdgeInsets){v,h,v,h} resizingMode:UIImageResizingModeStretch];
    
}

-(void)initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    [self addSubview:icon];
    self.icon=icon;
    
    UILabel *time=[[UILabel alloc ] init];
    [self addSubview:time];
    self.time=time;
    [time setTextColor:[UIColor grayColor]];
    [time setTextAlignment:NSTextAlignmentCenter];
    [time setFont:[UIFont systemFontOfSize:13]];
    
    UIButton *text=[[UIButton alloc] init];
    [self addSubview:text];
    self.text=text;
    [text.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [text setTitleEdgeInsets:(UIEdgeInsets){10,20,10,20}];
    [text setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [text.titleLabel setNumberOfLines:0];
    
}

@end
