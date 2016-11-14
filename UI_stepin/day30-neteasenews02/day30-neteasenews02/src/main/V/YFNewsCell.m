//
//  YFNewsCell.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsCell.h"
#import "YFNewsTV.h"
@interface YFNewsCell ()
@property (nonatomic,strong)YFNewsTV *tv;

@end

@implementation YFNewsCell


-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.tv=[[YFNewsTV alloc] initWithFrame:self.bounds];
        [self addSubview:self.tv];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setChan:(YFChannel *)chan{
    _chan=chan;
    [self.tv setChan:chan];
}

@end
