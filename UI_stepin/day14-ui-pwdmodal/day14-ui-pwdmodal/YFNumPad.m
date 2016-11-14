//
//  YFNumPad.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNumPad.h"
#import "Masonry.h"

@interface YFNumPad ()

@end

@implementation YFNumPad

+(instancetype)padWithDelegate:(id<YFNumPadDelegate>)delegate{
    return [[self alloc] initWithDelegate:delegate];
}
-(instancetype)initWithDelegate:(id<YFNumPadDelegate>)delegate{
    if(self=[super init]){
        self.delegate=delegate;
        [self initUI];
    }
    return self;
}




-(void)initUI{
    [self setBackgroundColor:[UIColor grayColor]];
    NSString *sary[]={@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"DEL",@"0",@"hide"};
    NSMutableArray *mary=[NSMutableArray array];
    
    for(int i=0;i<12;i++){
        UIButton *btn=[[UIButton alloc] init];
        [self addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"warning_button"] forState:UIControlStateNormal];
        [btn setTitle:sary[i] forState:UIControlStateNormal];
        [btn setTag:i];
        if([[self delegate]respondsToSelector:@selector(onPadBtnClicked:)])
            [btn addTarget:self.delegate   action:@selector(onPadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [mary addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(.33);
            make.height.equalTo(self).multipliedBy(.25);
            if(i%3)
                make.leading.equalTo([mary[i-1] mas_right]).offset(1);
            else
                make.leading.equalTo(@0);
            if(!(i/3))
               make.top.equalTo(self);
            else
                make.top.equalTo([mary[i-3] mas_bottom]).offset(1);
            
        }];
    }
    
    
}
@end
