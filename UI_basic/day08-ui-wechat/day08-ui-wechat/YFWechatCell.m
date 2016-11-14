//
//  YFWechatCell.m
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatCell.h"
#import "YFWechatF.h"
#import "YFWechatMod.h"

@interface YFWechatCell ()
@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak)UILabel *time;
@property(nonatomic,weak) UIButton *text;


@end

@implementation YFWechatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
        
    }
    return self;
}
-(void) initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    self.icon=icon;
    [self.contentView addSubview:icon];
    
    UILabel *time=[[UILabel alloc] init];
    [time setTextAlignment:NSTextAlignmentCenter];
    time.font=[UIFont systemFontOfSize:13];
    [time setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:time];
    self.time=time;
    
    UIButton *text=[[UIButton alloc] init];
    text.titleLabel.font=[UIFont systemFontOfSize:13];
    [text setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:text];
    [[text titleLabel] setNumberOfLines:0];
    [text setTitleEdgeInsets:(UIEdgeInsets){0,20,0,20}];
    self.text=text;
   
}

-(void)setF:(YFWechatF *)f{
    _f=f;
    [self updateUI];
}
-(void)updateUI{
    
    self.time.text=_f.mod.time;
    self.time.frame=_f.timeF;
    
    self.icon.frame=_f.iconF;
    self.text.frame=_f.textF;
    [self.text setTitle:_f.mod.text forState:UIControlStateNormal];
    
    if(_f.mod.type==ChatType_ME){
        [self.text setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"chat_send_nor"]] forState:UIControlStateNormal];
        [self.text setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"chat_send_press_pic"]] forState:UIControlStateHighlighted];
        self.icon.image=[UIImage imageNamed:@"me"];
    }else{
        [self.text setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"chat_recive_nor"]] forState:UIControlStateNormal];
        [self.text setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"chat_recive_press_pic"]] forState:UIControlStateHighlighted];
        self.icon.image=[UIImage imageNamed:@"other"];
    }
    
    
}

-(UIImage *)resizableImage:(UIImage *)img{
    CGFloat w=img.size.width/2;
    CGFloat h=img.size.height/2;
    return [img resizableImageWithCapInsets:(UIEdgeInsets){h,w,h,w} resizingMode:UIImageResizingModeStretch];
}


@end
