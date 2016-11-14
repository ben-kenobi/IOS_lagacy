//
//  OptionsView.m
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "OptionsView.h"


#define OPTSIZE {40,40}
#define COLCOUNT 7
#define WIDTHA 40


@interface OptionsView ()


@end


@implementation OptionsView
-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count{
    if(self = [super initWithFrame:frame]){
        int row,col;
        CGFloat gap=(self.frame.size.width-WIDTHA*COLCOUNT)/(COLCOUNT+1);
        for(int i=0;i<count;i++){
            row=i/COLCOUNT;
            col=i%COLCOUNT;
            [self addSubview:[self createTxtBtnWithFrame:(CGRect){(col+1)*gap+WIDTHA*col,row*(WIDTHA+gap),WIDTHA,WIDTHA} andBGImg:@"btn_option"
                                                        andHLImg:@"btn_option_hignlighted"]];
        }

    }
    return self;
}
+(instancetype)viewWithFrame:(CGRect)frame count:(NSInteger)count{
    return [[self alloc] initWithFrame:frame count:count];
}


-(void)hideOpt:(NSString *)hid show:(NSString *)show{
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *b = obj;
        if([b.currentTitle isEqualToString:hid]){
            b.hidden=YES;
        }
        if(show.length!=0&&[b.currentTitle isEqualToString:show]){
            b.hidden=NO;
        }
        
    }];

}


-(UIButton *)createTxtBtnWithFrame:(CGRect)frame andBGImg:(NSString *)img
                          andHLImg:(NSString *)hlimg
{
    UIButton *btn=[[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hlimg] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)onBtnClicked:(id)sender{
    if([_delegate respondsToSelector:@selector(onBtnClicked:)])
        [_delegate onBtnClicked:sender];
}
-(void)updateOptsWithMod:(HMGussMod *)mod{
    NSArray *options=mod.options;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self setOpt:obj withTit:options[idx]];
    }];
}
-(void)setOpt:(UIButton *)btn withTit:(NSString *)tit{
    [btn setTitle:tit forState:UIControlStateNormal];
    [btn setHidden:NO];
}
@end
