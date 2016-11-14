//
//  YFBannerCell.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBannerCell.h"
#import "YFChannel.h"

@implementation YFBannerCell


-(void)initUI{
    
    UILabel *lab=[[UILabel alloc] init];

    [lab setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:lab];
    self.lab=lab;

}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}


-(void) setChannel:(YFChannel *)channel{
    _channel=channel;
    [self updateUI];
}


-(void)updateUI{
    self.lab.text=self.channel.tname;
    [self refresh];
}
-(void)refresh{
    if(self.selected){
        [self.lab setFont:[UIFont systemFontOfSize:18]];
        self.lab.textColor=[UIColor redColor] ;
    }else{
        [self.lab setFont:[UIFont systemFontOfSize:14]];
        self.lab.textColor=[UIColor blackColor] ;
    }

}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.lab.frame=self.bounds;
    
}

@end
