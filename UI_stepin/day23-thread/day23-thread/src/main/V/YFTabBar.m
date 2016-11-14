//
//  YFTabBar.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTabBar.h"


#define COUNT 5



@interface YFTabBar ()



@end

@implementation YFTabBar


-(void)initUI{
    UIButton *btn;
    for(int i=0;i<COUNT;i++){
        btn=[[YFTabButton alloc] init];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar%d",i+1]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar%dSel",i+1]] forState:UIControlStateSelected];
        [self addSubview:btn];
        btn.tag=i;
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchDown];
        if(!i){
            [self onBtnClicked:btn];
        }
    }
}
-(void)selectAtIdx:(int)idx{
    [self onBtnClicked:self.subviews[idx]];
}

-(void)onBtnClicked:(UIButton *)sender{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
    }];
    [sender setSelected:YES];
    if(self.onTabChange){
        self.onTabChange(sender.tag);
    }
}

-(void)layoutSubviews{

    CGFloat w=self.w/COUNT,
    h=self.h;
    
    [super layoutSubviews];
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=obj;
        btn.frame=(CGRect){idx*w,0,w,h};
    }];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

@end


@implementation YFTabButton

-(void)setHighlighted:(BOOL)highlighted{
    
}

@end