//
//  ViewController.m
//  day06-ui-rectangle
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFShapeView.h"
#import "YFMainPanel.h"
#import "YFControlBoard.h"

@interface ViewController ()<ControlBoardDelegate>

@property (nonatomic,weak) YFMainPanel *panel;
@property (nonatomic,weak) YFControlBoard *conB;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    
}


-(void)initState{
    [self.panel initState];
    [self.conB initState];
    
}

-(void)operate:(UIButton *)sender{
    NSInteger tag=sender.tag;
    if(tag==Oper_Left){
        [self.panel moveHorizontal:-1];
    }else if(tag==Oper_Right){
        [self.panel moveHorizontal:1];
    }else if(tag==Oper_Pause){
        [self.conB updateBtn:[self.panel toggle]];
    }else if(tag==Oper_Restart){
        [self.panel setStop:YES];
        [self performSelector:@selector(initState) withObject:nil afterDelay:self.panel.interval];
    }else if(tag==Oper_Up){
        [self.panel rotate];
    }else if(tag==Oper_Down){
        [self.panel down];
    }
}


-(void)initUI{
    [YFShapeView setWid:18 andColor:[UIColor colorWithRed:.3 green:.3 blue:.3 alpha:1]];
    [self.view setBackgroundColor:[UIColor colorWithRed:.9 green:.9 blue:.8 alpha:1]];
    
    YFMainPanel *panel=[YFMainPanel panelWithFrame:(CGRect){30,30,0,0}];
    [panel setBackgroundColor:[UIColor colorWithRed:.6 green:.8 blue:.9 alpha:1]];
    [self.view addSubview:panel];
    self.panel=panel;
    
    YFControlBoard *conB=[YFControlBoard boardWithFrame:(CGRect){30,CGRectGetMaxY(self.panel.frame)+10,self.panel.frame.size.width,CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.panel.frame)-10} direc:YES pause:YES restart:YES];
    [conB setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:.7 alpha:1]];
    [self.view addSubview:conB];
    self.conB=conB;
   
}

@end
