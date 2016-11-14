//
//  ViewController.m
//  day13-ui-blackNwhite
//
//  Created by apple on 15/10/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    NSInteger rowcount;
    CGFloat wid,wid_2;
    UIButton *ary[5][2];
    CGPoint lc,rc;
}
@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)UIView *cover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
}


-(void)initUI{
    
    
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sv];
    self.sv=sv;
    
    wid=sv.bounds.size.width*.5;
    wid_2=wid*.5;
    lc=(CGPoint){wid_2,0};
    rc=(CGPoint){wid+wid_2,0};
    [self.sv setBackgroundColor:[UIColor grayColor]];
    for(int i=4;i>=0;i--){
        UIButton *l=[[UIButton alloc] initWithFrame:(CGRect){0,0,wid,wid}];
        [l setBackgroundColor:[UIColor blueColor]];
        ary[i][0]=l;
        [l addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchDown];
        l.tag=1;
        UIButton *r=[[UIButton alloc] initWithFrame:(CGRect){0,0,wid,wid}];
        [r setBackgroundColor:[UIColor orangeColor]];
        ary[i][1]=r;
        [r addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchDown];
        r.tag=2;
        [self.sv addSubview:r];
        [self.sv addSubview:l];
    }
}

-(void)initState{
    [self.sv setContentOffset:(CGPoint){0,0}];
    rowcount=0;
    [self addRow];
    [self addRow];
    
}

-(void)onBtnClicked:(UIButton *)sender{
    NSInteger tag=sender.tag;
    if(tag==2)
        [self addRow];
    else if(tag==1){
        [self cover];
    }else if(tag==3){
        _cover.hidden=YES;
        [self initState];
    }
}
-(void)addRow{
    
    lc.y=-rowcount*wid+wid_2;
    rc.y=-rowcount*wid+wid_2;
    
    BOOL b=[self leadingWithWhite];
    ary[rowcount%5][b].center=lc;
    ary[rowcount%5][!b].center=rc;
    
    [UIView animateWithDuration:.1 animations:^{
        [self.sv setContentOffset:(CGPoint){0,-rowcount*wid}];
    }];
    rowcount++;
}


-(UIView *)cover{
    if(!_cover){
        UIView *lab=[[UIView alloc] initWithFrame:self.view.bounds] ;
        _cover=lab;
        [self.view addSubview:lab];
        
        [lab setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.8]];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){0,0,150,50}];
        btn.center=lab.center;
        btn.backgroundColor=[UIColor orangeColor];
        [btn setTitle:@"restart" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:33];
        [lab addSubview:btn];
        btn.tag=3;
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    _cover.hidden=NO;
    return _cover;
}
-(BOOL)leadingWithWhite{
    return arc4random()&1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
