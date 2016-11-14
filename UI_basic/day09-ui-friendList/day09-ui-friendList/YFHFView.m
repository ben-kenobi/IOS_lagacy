
//
//  YFHFView.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHFView.h"
#import "YFFriListF.h"
#import "YFFriendList.h"


@interface YFHFView ()
@property (nonatomic,weak) UIButton *name;
@property (nonatomic,weak) UILabel *online;

@end

@implementation YFHFView

+(instancetype)viewWithTv:(UITableView *)tv andListF:(YFFriListF *)listf andDelegate:(id<YFHFViewDelegate>)delegate{
    static NSString *iden=@"hfviden";
    YFHFView *hfv=[tv dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if(nil==hfv){
        hfv=[[self alloc] initWithReuseIdentifier:iden];
        hfv.delegate=delegate;
    }
    [hfv setListF:listf];
    return hfv;
}


-(void)setListF:(YFFriListF *)listF{
    _listF=listF;
    [self updateUI];
}

-(void)updateUI{
    [self.name setTitle:_listF.frilist.name forState:UIControlStateNormal];
    self.name.frame=_listF.nameF;
    
    self.online.frame=_listF.onlineF;
    self.online.text=[NSString stringWithFormat:@"%ld/%ld",_listF.frilist.online,_listF.frilist.friends.count];
    if(!self.listF.frilist.isHide){
        self.name.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.name.imageView.transform=CGAffineTransformIdentity;
    }

   
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}


-(void)onBtnClicked:(UIButton *)sender{
    self.listF.frilist.hide=!self.listF.frilist.hide;
    [_delegate toggleSection:self];
    if(!self.listF.frilist.isHide){
        self.name.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.name.imageView.transform=CGAffineTransformIdentity;
    }
}

-(void)initUI{
    UIButton *name=[[UIButton alloc] init];
    self.name=name;
    [self.contentView addSubview:name];
    [name setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [name setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [name setContentEdgeInsets:(UIEdgeInsets){0,10,0,0}];
    [name setTitleEdgeInsets:(UIEdgeInsets){0,10,0,0}];
    [name setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [name addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    name.imageView.layer.masksToBounds=NO;
    [name.imageView setContentMode:UIViewContentModeCenter];

    
    UILabel *online=[[UILabel alloc] init];
    self.online=online;
    [self.contentView addSubview:online];
    [online setTextAlignment:NSTextAlignmentRight];
    [online setFont:[UIFont systemFontOfSize:13]];
    [online setTextColor:[UIColor grayColor]];
    
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
}

@end
