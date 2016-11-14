//
//  YFWheel.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWheel.h"
#import "UIColor+Extension.h"
#import "UIView+Ex.h"
#define  COUNT 12

@interface YFWheel ()<UIAlertViewDelegate>
@property (nonatomic,weak)UIView *baseV;
@property (nonatomic,weak)UIButton *go;
@property (nonatomic,weak)UIButton *sel;
@property (nonatomic,strong)CADisplayLink *link;
@end

@implementation YFWheel




-(void)onBtnClicked:(id)sender{
    if(sender==self.go){
        if(![_baseV.layer animationForKey:@"abc"]){
            CABasicAnimation *ca=[[CABasicAnimation alloc] init];
            ca.keyPath=@"transform.rotation";
            ca.toValue=@(4*M_PI-2*M_PI/COUNT*_sel.tag);
            ca.removedOnCompletion=NO;
            [ca setFillMode:kCAFillModeForwards];
            [ca setDuration:2];
            [self.baseV.layer addAnimation:ca forKey:@"abc"];
            self.link.paused=YES;
            self.baseV.userInteractionEnabled=NO;
            dispatch_after(dispatch_time(0, 1e9*ca.duration),dispatch_get_main_queue(),^{
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"aler" message:@"xxxxx" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:0, nil];
                 self.baseV.transform=CGAffineTransformMakeRotation([ca.toValue  doubleValue]);
                [aler show];
                
            });
        }
    }else if(sender==_link){
        self.baseV.transform=CGAffineTransformRotate(self.baseV.transform, M_PI/60/5);
        
    }else{
        [self.sel setSelected:NO];
        self.sel=sender;
        [self.sel setSelected:YES];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self initState];
    }
}

-(CADisplayLink *)link{
    if(!_link){
        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(onBtnClicked:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes ];
    }
    return _link;
}

-(void)initState{
    [self.baseV setUserInteractionEnabled:YES];
    self.link.paused=NO;
    [self.baseV.layer removeAnimationForKey:@"abc"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center=(CGPoint){self.bounds.size.width*.5,self.bounds.size.height*.5};
    _baseV.center=center;
    _go.center=center;
    static int i=0;
    NSLog(@"%@",NSStringFromCGRect(self.frame));

}
-(void)initUI{
    self.layer.contents=(__bridge id)[[UIImage imageNamed:@"LuckyBaseBackground"] CGImage];
    UIView *baseV=[[UIImageView alloc] init];
    self.baseV=baseV;
    [self addSubview:baseV];
    UIImage *wheelimg=[UIImage imageNamed:@"LuckyRotateWheel"];
    baseV.bounds=(CGRect){0,0,wheelimg.size};
    baseV.layer.contents=(__bridge id)[wheelimg CGImage];
    
    
    UIButton *go=[[UIButton alloc] init];
    UIImage *img=[UIImage imageNamed:@"LuckyCenterButton"];
    [go setImage:img forState:UIControlStateNormal];
    self.go=go;
    go.bounds=(CGRect){0,0,img.size};
    [go setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
    [self addSubview:go];
    [go addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn;
     img=[UIImage imageNamed:@"LuckyAstrology"];
    UIImage *pres=[UIImage imageNamed:@"LuckyAstrologyPressed"],
    *imgsel=[UIImage imageNamed:@"LuckyRototeSelected"];
    CGPoint baseVcenter=(CGPoint){baseV.w*.5,baseV.h*.5};
    for(int i=0;i<COUNT;i++){
        btn=[[UIButton alloc] init];
        [baseV addSubview:btn];
        [btn setImage:[self clipImg:img withIdx:i] forState:UIControlStateNormal];
        [btn setImage:[self clipImg:pres withIdx:i] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:imgsel forState:UIControlStateSelected];
        [btn setBounds:(CGRect){0,0,imgsel.size}];
        btn.layer.anchorPoint=(CGPoint){.5,1};
        [btn setImageEdgeInsets:(UIEdgeInsets){-60,0,0,0}];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.center=baseVcenter;
        btn.transform=CGAffineTransformMakeRotation(i*2*M_PI/COUNT);
        btn.tag=i;
    }

}

-(UIImage *)clipImg:(UIImage *)img withIdx:(NSInteger)idx{
    
    CGFloat w=img.size.width*[UIScreen mainScreen].scale/COUNT,
    h=img.size.height*[UIScreen mainScreen].scale;
    return  [UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], (CGRect){w*idx,0,w,h}) scale:2 orientation:0];
}

-(instancetype)init{
    if(self=[super init]){
        [self initUI];
        [self initState];
    }
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    if(self=[super initWithFrame:frame]){
//        [self initUI];
//        [self initState];
//    }
//    return self;
//}


@end
