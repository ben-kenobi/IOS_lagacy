//
//  ViewController.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFView.h"
#import "YFView02.h"
#import "Masonry.h"
#import "DrawPad.h"
#import "YFPieChart.h"
#import "UIColor+Extension.h"
#import "YFBarChart.h"
#import "DrawPad.h"
#import "YFView03.h"
#import "YFView04.h"
#import "YFView05.h"
#import "YFView06.h"
#import "YFView07.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)YFPieChart *pie;
@property (nonatomic,weak)YFBarChart *bar;
@property (nonatomic,weak)DrawPad *pad;
@property (nonatomic,weak)DrawPad *pad2;
@property (nonatomic,weak)YFView02 *yv;
@property (nonatomic,weak)YFView *v;
@property (nonatomic,weak)YFView04 *v04;
@property (nonatomic,weak)YFView06 *v06;
@property (nonatomic,weak)UIImageView *iv;


@property (nonatomic,weak)YFView07 *v07;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI6];
  
}

-(void)initUI6{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFView07 *v07=[[YFView07 alloc] init];
    self.v07=v07;
    [self.view addSubview:v07];
    [v07 setBackgroundColor:[UIColor clearColor] ];
    [v07 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.size.equalTo(self.view);
    }];
    
    
    
}
-(void)initUI5{
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]]];
    YFView06 *v06=[[YFView06 alloc] init];
    [self.view addSubview:v06];
    self.v06=v06;
//    [v06 setBackgroundColor:[UIColor redColor]];
    [v06 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(self.view.mas_width).offset(-20);
    }];
    [v06 setBackgroundColor:[UIColor clearColor]];
    
    [v06 setBlockDelegate:^BOOL(NSString *pwd) {
        UIGraphicsBeginImageContext(self.v06.bounds.size);
       CGContextRef con= UIGraphicsGetCurrentContext();
        [self.v06.layer renderInContext:con];
        [self.iv setImage:UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
        
        if([@"210" isEqualToString:pwd]){
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"alert" message:@"success" preferredStyle:1];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:0 handler:0]];
            [self presentViewController:alert animated:YES completion:nil];
            
            return YES;
        }else{
            return NO;
        }
    }];
    
    
    
    
}

-(void)initUI4{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]]];
    YFView04 *v04=[[YFView04 alloc] init];
    self.v04=v04;
    [v04 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:v04];
    [v04 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(self.view.mas_width).multipliedBy(.8);
    }];
    
    [v04 setDelegateBlock:^BOOL(NSString * str) {
        UIGraphicsBeginImageContext(self.v04.bounds.size);
        [self.v04.layer renderInContext:UIGraphicsGetCurrentContext()];
        [self.iv setImage:UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
        if([@"012" isEqualToString:str]){
            UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"alert" message:@"succes" preferredStyle:1];
            [aler addAction:[UIAlertAction actionWithTitle:@"OK" style:0 handler:0]];
            [self presentViewController:aler animated:YES completion:0];
            return YES;
        }else{
            return NO;
        }
    }];
    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.bottom.equalTo(v04.mas_top).offset(-20);
        make.centerX.equalTo(@0);
        make.width.equalTo(iv.mas_height);
    }];
}
-(void)initUI3{
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.multipleTouchEnabled=YES;

}

-(void)initUI2{
   
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFView02 *yv=[[YFView02 alloc] initWithImg:[UIImage imageNamed:@"me"]];
    [self.view addSubview:yv];
    self.yv=yv;
    
//    [yv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(@0);
//        make.bottom.equalTo(@-100);
//    }];
    [yv setBackgroundColor:[UIColor whiteColor]];
    
    YFView *v=[[YFView alloc] initWithFrame:(CGRect){200,200,200,200}];
    [self.view addSubview:v];
    self.v=v;
    
    
   
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIScrollView *sv=[[UIScrollView alloc] init];
    [self.view addSubview:sv];
    self.sv=sv;
    sv.delegate=self;
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(@-100);
    }];
    
    YFPieChart *pie=[[YFPieChart alloc] init];
    [sv addSubview:pie];
    self.pie=pie;
    [pie setBackgroundColor:[UIColor randomColor]];
    [pie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.sv).multipliedBy(.5);
        make.top.leading.equalTo(@0);
    }];
    pie.datas=@[@4,@11,@13,@12,@24];
    
    
    YFBarChart *bar=[[YFBarChart alloc] init];
    [sv addSubview:bar];
    self.bar=bar;
    
    [bar setBackgroundColor:[UIColor randomColor]];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(pie.mas_right);
        make.height.width.equalTo(self.sv).multipliedBy(.5);
    }];
    bar.datas=@[@4,@11,@13,@12,@24];
    bar.max=30;
    
    
    
    DrawPad *pad=[[DrawPad alloc] initWithStyle:0];
    self.pad=pad;
    [self.view addSubview:pad];
    [pad setBackgroundColor:[UIColor randomColor]];
    [pad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.height.width.equalTo(self.sv).multipliedBy(.5);
        make.top.equalTo(self.bar.mas_bottom);
    }];
    
    
    DrawPad *pad2=[[DrawPad alloc] initWithStyle:1];
    self.pad2=pad2;
    [self.view addSubview:pad2];
    [pad2 setBackgroundColor:[UIColor randomColor]];
    [pad2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pad.mas_right);
        make.height.width.equalTo(self.sv).multipliedBy(.5);
        make.top.equalTo(self.bar.mas_bottom);
    }];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint p1=[touch locationInView:self.view];
    CGPoint p2=[touch previousLocationInView:self.view];
    CGFloat deltax=p1.x-p2.x;
    CGFloat deltay=p1.y-p2.y;
    CGPoint center=_yv.center;
    center.x+=deltax*.3;
    center.y+=deltay*.3;
    _yv.center=center;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
       
//    self.yv.img=[UIImage imageNamed:@"Press"];
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, 0, 0);
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    [self.view.layer renderInContext:con];
//    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(img, 0, 0, 0);
   
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
