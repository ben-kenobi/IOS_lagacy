//
//  HMAnswerView.m
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMAnswerView.h"


#define WIDTHA 40

@implementation HMAnswerView


+(instancetype)viewWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}


-(void)updateAnserWithMod:(HMGussMod *)mod{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger len = mod.answer.length;
    CGFloat gap=20;
    CGFloat startX=(self.frame.size.width-(gap+WIDTHA)*len+gap)/2;
    for(int i=0;i<len;i++){
        [self addSubview:[self createTxtBtnWithFrame:(CGRect){startX+i*(gap+WIDTHA),0,WIDTHA,WIDTHA} andBGImg:@"btn_answer" andHLImg:@"btn_answer_highlighted"]];
    }
    
    
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

-(void)onBtnClicked:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(onBtnClicked:)])
       [_delegate onBtnClicked:sender];
    [sender setTitle:@"" forState:UIControlStateNormal];
}

-(void)updateAnswerColor:(UIColor *)cl{
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *b=obj;
        [b setTitleColor:cl forState:UIControlStateNormal];
    }];
}


-(NSString *)tipByMod:(HMGussMod *)mod replaced:(NSString **)replaced complete:(BOOL *)com{
    __block BOOL complete=YES;
    __block NSString *rep;
    __block int count=0;
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=obj;
        NSString *str= [mod.answer substringWithRange:(NSRange){idx,1}];
        if([btn currentTitle].length==0&&count)
            *stop=YES,complete=NO;
        if(([btn currentTitle].length==0||![[btn currentTitle] isEqualToString:str])&&count==0)
        {
            rep=str;
            *replaced=[self replaceAnswer:btn with:str],count=1;
        }
    }];
    *com=complete;
    return rep;
    
}

-(NSString *)replaceAnswer:(UIButton *)btn with:(NSString *)title{
    NSString *str=btn.currentTitle;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *b = obj;
        if([b.currentTitle isEqualToString:title])
            [b setTitle:@"" forState:UIControlStateNormal];
    }];
    [btn setTitle:title forState:UIControlStateNormal];
    return str;
}

-(NSString *)addTitle:(NSString *)tit complete:(BOOL *)complete{
    __block NSString * added=nil;
    __block int count=0;
    *complete=YES;
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=obj;
        if(!btn.currentTitle.length){
            if(count==0){
                added=tit;
                [btn setTitle:added forState:UIControlStateNormal];
                count=1;
            }else{
                *complete=NO;
                *stop=YES;
            }
        }
        
    }];
    
    return added;

}

@end
