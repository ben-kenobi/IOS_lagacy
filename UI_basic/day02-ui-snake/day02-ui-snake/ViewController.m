//
//  ViewController.m
//  day02-ui-snake
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFMainPanel.h"
#import "YFControlBoard.h"

@interface ViewController ()<YFMainPanelDelegate>
@property (nonatomic,weak)YFMainPanel *mainPanel;

@property (nonatomic,weak) UILabel *score;
@property (nonatomic,weak) YFControlBoard *controlBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self startScreen];
    [self initListeners];
}
-(void) initState{
    
    [_mainPanel initState];
    [self.controlBoard initState];
    
    [UIView animateWithDuration:.3 animations:^{
        [[self.view viewWithTag:101] setAlpha:0];
        [[self.view viewWithTag:102] setAlpha:0];
        [[self.view viewWithTag:101] setTransform:CGAffineTransformMakeScale(.2, .2)];
        [[self.view viewWithTag:102] setTransform:CGAffineTransformMakeScale(.2, .2)];
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:101] removeFromSuperview];
        [[self.view viewWithTag:102] removeFromSuperview];
    }];
    
    
}


-(void) initListeners{
    
}


-(void)operate:(UIButton *)sender{
    NSInteger tag=sender.tag;
    if(tag==Oper_Pause){
        [self toggle];
    }else if(tag==Oper_Restart){
        ((UIButton *) [self.controlBoard viewWithTag:Oper_Restart]).enabled=NO;
        _mainPanel.stop=YES;
        [self performSelector:@selector(initState) withObject:nil afterDelay:_mainPanel.interval];
    }else{
        _mainPanel.direct=tag;
    }
    
}




-(void)toggle{
    _mainPanel.stop=!_mainPanel.stop;
    [_mainPanel move:NO];
    [self.controlBoard updateBtn:_mainPanel.stop];
}


-(void)updateScore{
    self.score.text=[NSString stringWithFormat:@"count:%ld | score:%ld",_mainPanel.snakeLen,_mainPanel.score];
}


-(void)startScreen{
    UIView *cover = [[UIView alloc ]initWithFrame:self.view.frame];
    [cover setBackgroundColor:[UIColor blackColor]];
    cover.alpha=0;
    cover.transform=CGAffineTransformMakeScale(.1, .1);
    [UIView animateWithDuration:.5 animations:^{
        cover.alpha=.6;
        cover.transform=CGAffineTransformIdentity;
    }];
    cover.tag=102;
    CGPoint cent=cover.center;
    
    UILabel *lab=[[UILabel alloc] initWithFrame:(CGRect){0,cent.y-150,cent.x*2,40}];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setTextColor:[UIColor colorWithRed:.4 green:.5 blue:.8 alpha:1]];
    [lab setFont:[UIFont boldSystemFontOfSize:29]];
    [lab setShadowColor:[UIColor colorWithRed:.8 green:.5 blue:.4 alpha:1]];
    [lab setShadowOffset:(CGSize){1,-1}];
    [lab setText:@"START ?"];
    [cover addSubview:lab];
    
    UIButton *go=[[UIButton alloc] initWithFrame:(CGRect){cent.x-70,cent.y-70,140,140}];
    [go setBackgroundColor:[UIColor colorWithRed:.8 green:.7 blue:.9 alpha:.5]];
    [go setTitle:@"GO" forState:UIControlStateNormal];
    [go setTitleColor:[UIColor colorWithRed:.3 green:.7 blue:.4 alpha:1] forState:UIControlStateNormal];
    [go.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
    [go.titleLabel setShadowOffset:(CGSize){1,-1}];
    [go setTitleShadowColor:[UIColor colorWithRed:.5 green:.6 blue:.9 alpha:1] forState:UIControlStateNormal];
    [go addTarget:self action:@selector(initState) forControlEvents:UIControlEventTouchUpInside];
    [cover addSubview:go];
    
    
    
    
    [self.view addSubview:cover];
}
-(void)gameOver{
    if([self.view viewWithTag:101])
        return ;
    CGRect rect=self.view.frame;
    UIView *smoke=[[UIView alloc] initWithFrame:rect];
    smoke.backgroundColor=[UIColor whiteColor];
    [smoke setAlpha:.7];
    smoke.tag=101;
    [self.view addSubview:smoke];
    
    UILabel *label=[[UILabel alloc] initWithFrame:(CGRect){
        rect.size.width*.2,CGRectGetMidY(rect)-120,rect.size.width*.6,100}];
    label.text=@"--GAME--\nOVER!";
    label.textColor=[UIColor colorWithRed:.8 green:.2 blue:.3 alpha:1];
    label.textAlignment=NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:38 weight:1]];
    [label setNumberOfLines:2];
    [label setShadowColor:[UIColor grayColor]];
    [label setShadowOffset:(CGSize){1,3}];
    [smoke addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){rect.size.width*.2,CGRectGetMidY(rect)+20,rect.size.width*.6,100}];
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    button.titleLabel.font=[UIFont systemFontOfSize:33 weight:1];
    [button.titleLabel setShadowOffset:(CGSize){1,2}];
    [button setTitle:@"RESTART" forState:UIControlStateNormal];
    [button setTitleShadowColor:UIColor.grayColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:.3 green:.3 blue:1 alpha:1] forState:UIControlStateNormal];
    [button setTitle:@"RESTART" forState:UIControlStateNormal];
    [button setTitleShadowColor:UIColor.grayColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.7 alpha:1] forState:UIControlStateHighlighted];
    button.backgroundColor=[UIColor colorWithRed:.7 green:.3 blue:.5 alpha:.5];
    [smoke addSubview:button];
    
    [button addTarget:self action:@selector(initState) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void) initUI{
    CGPoint mid=self.view.center;
    self.view.backgroundColor=[UIColor cyanColor];
    
    int width=(int)mid.x*2/100*100;
    int height=(int)mid.y*2/10*10-40-BTNSIZE*2-30-30;
    YFMainPanel *panel=[YFMainPanel viewWithFrame:(CGRect){(mid.x*2-width)/2,
        40,width,height} bg:[UIColor colorWithRed:.9 green:.85 blue:.7 alpha:1]];
    [self.view addSubview:panel];
    self.mainPanel=panel;
    self.mainPanel.delegate=self;
    
    UILabel *score =[[UILabel alloc] initWithFrame:(CGRect){mid.x/2,15,mid.x*1.4,24}];
    [score setTextColor:[UIColor colorWithRed:.5 green:.3 blue:.1 alpha:1]];
    [score setFont:[UIFont systemFontOfSize:13]];
    [score setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:score];
    self.score=score;
    
    YFControlBoard *controlB=[YFControlBoard boardWithFrame:CGRectMake(20, CGRectGetMaxY(self.mainPanel.frame)+10,mid.x*2-40, CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.mainPanel.frame)-20) direc:YES pause:YES restart:YES];
    [controlB setBackgroundColor:[UIColor colorWithRed:.3 green:.5 blue:.2 alpha:1]];
    [self.view addSubview:controlB];
    self.controlBoard=controlB;
    
}




@end
