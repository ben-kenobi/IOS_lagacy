//
//  YFNewsCell.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsCell.h"
#import "YFNewsTV.h"
@interface YFNewsCell ()
@property (nonatomic,weak)YFNewsTV *tv;

@end

@implementation YFNewsCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    YFNewsTV *tv=[[YFNewsTV alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tv=tv;
    [self addSubview:tv];
}

-(void)setChan:(YFChannel *)chan{
    _chan=chan;
    [self.tv setChan:chan];
}


@end
