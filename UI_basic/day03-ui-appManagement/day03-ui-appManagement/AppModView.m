//
//  AppModView.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppModView.h"
#import "AppMod.h"

#define IMGRECT (CGRect){17,3,46,46}
#define LABRECT (CGRect){0,50 ,80,15}
#define BTNRECT (CGRect){10,68 ,60,20}

@interface AppModView()
@property (nonatomic,strong) UIImageView *img;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,weak) UIView *mainV;
@end


@implementation AppModView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIFont *font=[UIFont systemFontOfSize:13];
    self.img=[[UIImageView alloc] initWithFrame:IMGRECT];
   
    [self addSubview:_img];
    
    self.title=[[UILabel alloc] initWithFrame:LABRECT];
   
    _title.font=font;
    _title.textColor=[UIColor blackColor];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_title];
    
    self.btn=[[UIButton alloc] initWithFrame:BTNRECT];
    _btn.titleLabel.font=font;
    [_btn setTitle:@"下载" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor colorWithRed:.9 green:.8 blue:.7 alpha:1] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[UIImage imageNamed:@"textField_border"] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[UIImage imageNamed:@"textField_normal"] forState:UIControlStateHighlighted];
    [_btn setTitle:@"以下载" forState:UIControlStateDisabled];
    [self addSubview:_btn];
    
    self.clipsToBounds=YES;
    self.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:0 alpha:1];
}
-(void)setMod:(AppMod *)mod{
    if(_mod!=mod){
        _mod=mod;
        [_img setImage:mod.img];
        [_title setText:mod.title];
    }
}

+(instancetype)modViewWithMod:(AppMod *)mod frame:(CGRect)frame mainV:(UIView *)mainV{
    AppModView * obj=[[self alloc] initWithFrame:frame];
    [obj.btn addTarget:obj action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [obj setMod:mod];
    obj.mainV=mainV;
    return obj;
}


-(void)btnClick:(id)sender{
     UIView *cover = [[UIView alloc] initWithFrame:_mainV.frame];
    UILabel *lab=[[UILabel alloc ]initWithFrame:_mainV.frame];
    [cover addSubview:lab];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setTextColor:[UIColor whiteColor]];
    lab.font=[UIFont boldSystemFontOfSize:23];
    lab.text=@"Downloading...";
    [cover setBackgroundColor:[UIColor blackColor]];
    cover.alpha=0;
    [_mainV addSubview:cover];
    [UIView animateWithDuration:.7 animations:^{
        cover.alpha=.7;
    } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:.6 delay:1 options:0 animations:^{
            cover.alpha=0;
        } completion:^(BOOL finished) {
            [cover removeFromSuperview];
            self.btn.enabled=false;
        }];
    }];
    
}

@end
