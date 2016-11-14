//
//  YFWheel.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWheel.h"
#import "YFCate.h"
#import "YFTabBar.h"

#define COUNT 12

@interface YFWheel ()<UIAlertViewDelegate>

@property (nonatomic,weak) UIView *view;
@property (nonatomic,weak)UIImageView *wheel;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,strong)CADisplayLink *link;
@property (nonatomic,weak)UIButton *selected;
@end

@implementation YFWheel

-(CADisplayLink *)link{
    if(!_link){
        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(onBtnClicked:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self initState];

}
-(void)onBtnClicked:(id)sender{
    if(sender==self.btn){
        if(![self.wheel.layer animationForKey:@"123"]){
            CABasicAnimation *ba=[[CABasicAnimation alloc] init];
            ba.keyPath=@"transform.rotation";
            ba.toValue=@(-4*M_PI-self.selected.tag*2*M_PI/COUNT);
            [ba setRemovedOnCompletion:NO];
            [ba setFillMode:kCAFillModeForwards];
            [ba setDuration:2];
            [self.wheel.layer addAnimation:ba forKey:@"123"];
            self.link.paused=YES;
            self.wheel.userInteractionEnabled=NO;
            dispatch_after(dispatch_time(0, 1e9*ba.duration), dispatch_get_main_queue(), ^{
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"aler" message:@"weqweqweq" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                 self.wheel.transform=CGAffineTransformMakeRotation([ba.toValue doubleValue]);
                
            });

        }
    }else if(sender==self.link){
        self.wheel.transform=CGAffineTransformRotate(self.wheel.transform, -M_PI/60/5);
    }else{
        self.selected.selected=NO;
        self.selected=sender;
        self.selected.selected=YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.view.frame=self.bounds;
    CGPoint center=self.view.innerCenter;
    self.wheel.center=center;
    self.btn.center=center;
}

-(void)initUI{
    UIView *view=[[UIView alloc] init];
    view.layer.contents=(__bridge id)[[UIImage imageNamed:@"LuckyBaseBackground"]CGImage];
    self.view=view;[self addSubview:view];
    
    UIImageView *wheel=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LuckyRotateWheel"]];
    self.wheel=wheel;
    [self.view addSubview:self.wheel];
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *b;
    NSString *img1=@"LuckyAstrology",*img2=@"LuckyAstrologyPressed";
    for(int i=0;i<COUNT;i++){
        b=[[YFTabButton alloc] init];
        [b setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:
         UIControlStateSelected];
        b.size=[UIImage imageNamed:@"LuckyRototeSelected"].size;
        b.center=wheel.innerCenter;
        b.layer.anchorPoint=(CGPoint){.5,1};
        [wheel addSubview:b];
        b.transform=CGAffineTransformMakeRotation(i*2*M_PI/COUNT);
        b.tag=i;
        [b setImage:[self clipImg:img1 byIdx:i] forState:UIControlStateNormal];
        [b setImage:[self clipImg:img2 byIdx:i] forState:UIControlStateSelected];
        [b setImageEdgeInsets:(UIEdgeInsets){-60,0,0,0}];
        [b addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchDown];
    }
   
}

-(UIImage *)clipImg:(NSString *)img byIdx:(int)idx{
    UIImage *im=[UIImage imageNamed:img];
    CGFloat w=im.size.width/COUNT*[UIScreen mainScreen].scale,
    h=im.size.height*[UIScreen mainScreen].scale;
   CGImageRef imgr= CGImageCreateWithImageInRect([im CGImage],(CGRect){idx*w,0,w,h});
   im= [UIImage imageWithCGImage:imgr scale:2 orientation:0] ;
    CGImageRelease(imgr);
    return im;
    
}


-(void)initState{
    self.wheel.userInteractionEnabled=YES;
    self.link.paused=NO;
    [self.wheel.layer removeAnimationForKey:@"123"];

}
-(instancetype)init{
    if(self=[super init]){
        [self initUI];
        [self initState];
    }
    return self;
}
@end
