//
//  ViewController.m
//  day02-ui-moveimgCode
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMImageMo.h"

#define ARYPATH @"Property List.plist"

@interface ViewController ()
@property(nonatomic,weak)UILabel *page;
@property(nonatomic,weak)UIImageView *img;
@property(nonatomic,weak)UILabel *comment;
@property(nonatomic,weak)UIButton *prev;
@property(nonatomic,weak)UIButton *next;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSMutableArray *ary;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect=self.view.frame;
    NSInteger midX=CGRectGetMidX(rect);
    UILabel * page=[[UILabel alloc] initWithFrame:(CGRect){0,0,60,30}];
    page.center=(CGPoint){midX,CGRectGetMidY(page.frame)+20};
    [page setTextAlignment:NSTextAlignmentCenter];
    page.textColor=UIColor.redColor;
    [self.view addSubview:page];
    self.page=page;
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:(CGRect){midX-150/2,CGRectGetMaxY(page.frame)+15,150,150}] ;
    self.img=img;
    [self.view addSubview:img];
    
    UILabel *comment=[[UILabel alloc] initWithFrame:(CGRect){midX-150/2,
        CGRectGetMaxY(img.frame)+15,150,60}];
    comment.textColor=UIColor.blueColor;
    comment.textAlignment=NSTextAlignmentCenter;
    comment.numberOfLines=0;
    [self.view addSubview:comment];
    self.comment=comment;
    
    
    self.prev=[self createButtonWithFram:(CGRect){CGRectGetMinX(comment.frame)-10,CGRectGetMaxY(comment.frame)+15,60,30} andTitle:@"prev" on:self.view];

    
    self.next=[self createButtonWithFram:(CGRect){CGRectGetMaxX(comment.frame)+10-60,CGRectGetMaxY(comment.frame)+15,60,30} andTitle:@"next" on:self.view];

    
    self.index=0;
    
    [self updateViews];

    
}

-(UIButton *)createButtonWithFram:(CGRect)frame andTitle:(NSString *)title
                               on:(UIView *)view{
    UIButton *b=[[UIButton alloc]initWithFrame:frame];
    [b setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [b setTitle:title forState:UIControlStateNormal];
    [b setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    [b setTitleColor:UIColor.yellowColor forState:UIControlStateHighlighted];
    [b setBackgroundColor:UIColor.blueColor];
    [view addSubview:b];
    [b addTarget:self action:@selector(changeimg:) forControlEvents:UIControlEventTouchUpInside];

    return b;
    
}
-(void)changeimg:(id)sender{
    if(sender==_prev)
        _index--;
    else if(sender==_next)
        _index++;
    [self updateViews];
}
-(void)updateViews{
    HMImageMo *mo = self.ary[_index];
    _page.text=[NSString stringWithFormat:@"%ld/%ld",_index+1,_ary.count ];
    _comment.text=mo.comment;
    _img.image=[UIImage imageNamed:mo.img];
    _prev.enabled=_index>0;
    _next.enabled=_index<_ary.count-1;
}
-(NSArray*)ary{
    if(nil==_ary){
        _ary=[NSMutableArray array];
        
        NSArray *ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:ARYPATH ofType:nil]];
        for(NSDictionary *dict in ary){
            HMImageMo *mo=[HMImageMo imageMoWithDict:dict];
            [_ary addObject:mo];
        }
    }
    return _ary;
}



@end
