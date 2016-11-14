//
//  YFHFv.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHFv.h"
#import "YFFris.h"
@interface YFHFv ()

@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UILabel *lab;

@end


@implementation YFHFv


+(instancetype)viewWithTableView:(UITableView *)tv andFris:(YFFris *)fris delegate:(id<YFHFvDelegate>)delegate{
    static NSString *iden=@"frisHfvIden";
    YFHFv *hfv=[tv dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if(!hfv){
        hfv=[[self alloc] initWithReuseIdentifier:iden];
        hfv.delegate=delegate;
    }
    [hfv setFris:fris];
    return hfv;
    
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)setFris:(YFFris *)fris{
    _fris=fris;
    [self updateUI];
    
}

-(void)updateUI{
    self.lab.text=[NSString stringWithFormat:@"%ld/%ld",_fris.online,_fris.friends.count];
    [self.btn setTitle:_fris.name forState:UIControlStateNormal];
    
    [self updateArrow];
}
-(void)updateArrow{
    if(_fris.open){
        self.btn.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btn.imageView.transform=CGAffineTransformIdentity;
    }
}


-(void) initUI{
    UIImageView *iv=[[UIImageView alloc] init];
    iv.image=[UIImage imageNamed:@"buddy_header_bg"];
    [self setBackgroundView:iv];
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){0,0,200,50}];
    self.btn=btn;
    [self addSubview:btn];
    [btn setContentEdgeInsets:(UIEdgeInsets){0,10,0,10}];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,10,0,10}];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [btn.imageView setContentMode:UIViewContentModeCenter];
    [btn.imageView.layer setMasksToBounds:NO];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    CGFloat wid=[[UIScreen mainScreen] bounds].size.width;
    UILabel *lab=[[UILabel alloc] initWithFrame:(CGRect){200,0,wid-210,50}];
    [self addSubview:lab];
    self.lab=lab;
    [lab setFont:[UIFont systemFontOfSize:13]];
    [lab setTextAlignment:NSTextAlignmentRight];
    [self.lab setTextColor:[UIColor grayColor]];
    
    
}
-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        _fris.open=!_fris.open;
        [self updateArrow];
        [self.delegate onBtnClicked:self];
    }
}

@end
