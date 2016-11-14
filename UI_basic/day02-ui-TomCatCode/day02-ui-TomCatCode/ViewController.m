//
//  ViewController.m
//  day02-ui-TomCatCode
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak) UIImageView *imgV;
@property(nonatomic,weak) UIButton *eat;
@property(nonatomic,weak) UIButton *head;
@property(nonatomic,weak) UIButton *scratch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgV=[self createImageVWithFrame:self.view.frame andImg:@"angry_00.jpg"on:self.view];
    CGRect main= self.view.frame;
    CGFloat midY=CGRectGetMidY(main);
    CGFloat maxX=CGRectGetMaxX(main);
    self.eat=[self createButtonWithFrame:(CGRect){30,midY,50,50} andImg:@"eat.png" on:self.view];
    self.head=[self createButtonWithFrame:(CGRect){90,120,190,190} andImg:nil on:self.view];
    self.scratch=[self createButtonWithFrame:(CGRect){maxX-30-50,midY,50,50} andImg:@"scratch.png" on:self.view];
    
}

-(UIImageView *)createImageVWithFrame:(CGRect)frame andImg:(NSString *)img on:(UIView *)view{
    UIImageView *iv=[[UIImageView alloc] initWithFrame:frame];
    iv.image=[UIImage imageNamed:img];
    [view addSubview:iv];
    
    
    return iv;
}
-(UIButton *)createButtonWithFrame:(CGRect)frame andImg:(NSString *)img on:(UIView *)view{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame=frame;
    [b setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [view addSubview:b];
    [b addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return b;
}

-(void)btnClicked:(UIButton *)sender{
    if(sender==_eat){
        [self animateWithPrefix:@"angry_" from:0 to:25 andRepeat:1 andInterval:.1];
    }else if(sender == _head){
        [self animateWithPrefix:@"stomach_" from:0 to:33 andRepeat:1 andInterval:.1];
    }else if(sender==_scratch){
        [self animateWithPrefix:@"scratch_" from:0 to:55 andRepeat:1 andInterval:.05];
    }
}
-(void)animateWithPrefix:(NSString *)pref from:(NSInteger)from to:(NSInteger)to
               andRepeat:(NSInteger)count andInterval:(CGFloat)interval{
    if(self.imgV.isAnimating) return;
    NSMutableArray *mary = [NSMutableArray array];
    for(NSUInteger i=from;i<=to;i++){
       [mary addObject: [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%02ld.jpg",pref,i] ofType:nil ]]];
    }
    self.imgV.animationImages=mary;
    self.imgV.animationDuration=(to-from)*interval;
    self.imgV.animationRepeatCount=count;
    [self.imgV startAnimating];
    [self.imgV performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imgV.animationDuration];
}

@end
