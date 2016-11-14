//
//  YFBannerCell.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBannerCell.h"
#import "YFChannel.h"
@interface YFBannerCell ()
@property (nonatomic,strong)UILabel *lab;

@end

@implementation YFBannerCell

-(void)initUI{
    self.lab=[[UILabel alloc] init];
    [self.contentView addSubview:self.lab];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if( self =[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)setChan:(YFChannel *)chan{
    _chan=chan;
    self.lab.text=_chan.tname;
    [self refresh];
}
-(void)refresh{
    if(self.selected){
        [self.lab setFont:[UIFont systemFontOfSize:18]];
        self.lab.textColor=[UIColor redColor];
    }else{
        [self.lab setFont:[UIFont systemFontOfSize:14]];
        self.lab.textColor=[UIColor blackColor];
    }
}

@end
