//
//  ViewController.m
//  day02-ui-transformCode
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIView *redView;
@property(nonatomic,strong)UIButton *translate;
@property(nonatomic,strong)UIButton *rotate;
@property(nonatomic,strong)UIButton *scale;
@property(nonatomic,strong)UIButton *reset;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect main=self.view.frame;
    NSInteger midX=CGRectGetMidX(main);
    self.redView=[[UIView alloc] initWithFrame:(CGRect){midX-150/2,20,150,150}];
    _redView.backgroundColor=UIColor.redColor;
    [self.view addSubview:_redView];
    
    NSInteger maxY=CGRectGetMaxY(self.redView.frame);
    self.translate=[self createButtonWithFrame:(CGRect){20,maxY+30,60,25} andTitle:@"translate" on:self.view];
    self.rotate=[self createButtonWithFrame:(CGRect){midX/2+20,maxY+30,60,25} andTitle:@"rotate" on:self.view];
    self.scale=[self createButtonWithFrame:(CGRect){midX+20,maxY+30,60,25} andTitle:@"scale" on:self.view];
    self.reset=[self createButtonWithFrame:(CGRect){midX+midX/2+20,maxY+30,60,25} andTitle:@"reset" on:self.view];
    

    
}
-(UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title on:(UIView *)view{
    UIButton *b=[UIButton buttonWithType:UIButtonTypeSystem];
    b.frame=frame;
    [b setTitle:title forState:UIControlStateNormal];
    b.titleLabel.textAlignment=NSTextAlignmentCenter;
    b.backgroundColor=UIColor.cyanColor;
    [view addSubview:b];
    [b addTarget:self action:@selector(transform:) forControlEvents:UIControlEventTouchUpInside];
    return b;
}
-(void)transform:(id)sender{
    if(sender==_translate){
        _redView.transform=CGAffineTransformTranslate(_redView.transform, 10, 10);
    }else if(sender==_rotate){
        _redView.transform=CGAffineTransformRotate(_redView.transform, M_PI_4/2);
    }else if(sender==_scale){
        _redView.transform=CGAffineTransformScale(_redView.transform, 1.1, 1.1);
    }else if(sender==_reset){
        _redView.transform=CGAffineTransformIdentity;
    }
    NSLog(@"%@",NSStringFromCGRect(_redView.frame));
}



@end
