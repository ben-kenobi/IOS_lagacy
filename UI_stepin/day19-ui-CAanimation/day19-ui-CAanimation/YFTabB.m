//
//  YFTabB.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTabB.h"
@interface YFButon :UIButton
@end


@interface YFTabB ()
@property (nonatomic,weak)YFButon *cur;


@end

@implementation YFTabB


-(void)addBtnWithImg:(UIImage *)img selImg:(UIImage *)selImage{
    YFButon *btn=[[YFButon alloc] init];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchDown];

}


-(void)onBtnClicked:(id)sender{
    [_cur setSelected:NO];
    _cur=sender;
    [_cur setSelected:YES];
    NSInteger idx=[sender tag];
    if(self.onBtnClickedAtIdx){
        self.onBtnClickedAtIdx(idx);
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count=self.subviews.count;
    CGSize size=self.bounds.size,
    btnsize ={size.width/count,size.height};
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        YFButon *btn=obj;
        btn.frame=(CGRect){idx*btnsize.width,0,btnsize};
        btn.tag=idx;
        if(idx==0)
            [self onBtnClicked:btn];
    }];
    
    
}


@end


@implementation YFButon
-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
