




//
//  YFChatCell.m
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFChatCell.h"
#import "YFChatF.h"
#import "YFChatMod.h"

@interface YFChatCell ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UIButton *text;
@property (nonatomic,weak) UILabel *time;

@end


@implementation YFChatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void) initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    [self.contentView addSubview:icon];
    self.icon=icon;
    
    UIButton *text=[[UIButton alloc] init];
    [text setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [text.titleLabel setNumberOfLines:0];
    [self.contentView addSubview:text];
    self.text=text;
    
    UILabel *time=[[UILabel alloc] init];
    [self.contentView addSubview:time];
    [time setTextAlignment:NSTextAlignmentCenter];
    [time setTextColor:[UIColor grayColor]];
    [time setFont:[UIFont systemFontOfSize:13]];
    self.time=time;
}

-(void)setChaf:(YFChatF *)chaf{
    _chaf=chaf;
    [self updateUI];
}

-(UIImage *)resizableImgWithName:(NSString *)name{
    UIImage  *img=[UIImage imageNamed:name];
    CGFloat w=img.size.width/2,
    h=img.size.height/2;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
}
-(void)updateUI{
    UIImage *head;
    if(_chaf.mod.type==ChatType_O){
        head=[UIImage imageNamed:@"other"];
        
        [_text setBackgroundImage:[self resizableImgWithName:@"chat_recive_nor"] forState:UIControlStateNormal];
        [_text setBackgroundImage:[self resizableImgWithName:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }else{
        head=[UIImage imageNamed:@"me"];
        [_text setBackgroundImage:[self resizableImgWithName:@"chat_send_nor"] forState:UIControlStateNormal];
        [_text setBackgroundImage:[self resizableImgWithName:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }
    self.icon.image=head;
    self.icon.frame=_chaf.iconF;
    
    [self.text setTitle:_chaf.mod.text forState:UIControlStateNormal];
    
    self.text.frame=_chaf.textF;
    
    CGFloat h=10;
    CGFloat w=15;
    [_text setContentEdgeInsets:(UIEdgeInsets){h,w,h,w}];

    
    self.time.frame=_chaf.timeF;
    self.time.text=_chaf.mod.time;
}


@end
