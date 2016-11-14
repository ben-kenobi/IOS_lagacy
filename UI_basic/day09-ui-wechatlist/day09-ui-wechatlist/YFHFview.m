//
//  YFHFview.m
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHFview.h"
#import "YFFriendList.h"

@interface YFHFview ()

@property (nonatomic, weak) UILabel *online;
@property (nonatomic, weak) UIButton *name;

@end


@implementation YFHFview

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}


-(void)setMod:(YFFriendList *)mod{
    _mod=mod;
    [self updateUI];
}

-(void)updateUI{
    [self.name setTitle:_mod.name forState:UIControlStateNormal];
    
    self.online.text=[NSString stringWithFormat:@"%ld/%ld",_mod.online,_mod.friends.count];
    if(_mod.isHide){
         self.name.imageView.transform=CGAffineTransformIdentity;
    }else{
       
        self.name.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }

}

-(void)updateSubviewsFrame{
   CGFloat hei=self.bounds.size.height,pad=10,wid=self.bounds.size.width;
    self.name.frame=CGRectMake(0, 0, wid, hei);
    self.online.frame=CGRectMake(0, 0, wid-pad, hei);
}

-(void)initUI{
    
    
    [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buddy_header_bg"]]];
    
    UIButton *btn=[[UIButton alloc] init];
    self.name=btn;
    [self.contentView addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [self.name addTarget:self  action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.name setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [self.name setContentEdgeInsets:(UIEdgeInsets){0,15,0,0}];
    
    [self.name.imageView setContentMode:UIViewContentModeCenter];
    [self.name.imageView.layer setMasksToBounds:NO];
    
     UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    [self.name setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
   
    [self.name setTitleEdgeInsets:(UIEdgeInsets){00,10,0,0}];
    
    self.online=createLab(self.contentView);
    [self.online setTextAlignment:NSTextAlignmentRight];

    [self.online setTextColor:[UIColor grayColor]];
    [self.online setFont:[UIFont systemFontOfSize:14]];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateSubviewsFrame];
    
}

-(void)onBtnClicked:(UIButton *)sender{
    [_mod setHide:!_mod.hide];
    [_delegate toggleList:self];
    if(_mod.isHide){
        self.name.imageView.transform=CGAffineTransformIdentity;
    }else{
        
        self.name.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }
}

@end
