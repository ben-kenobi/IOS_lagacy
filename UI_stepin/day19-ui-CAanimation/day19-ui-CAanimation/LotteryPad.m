//
//  LotteryPad.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "LotteryPad.h"
#define  COUNT 12

@interface LotteryPad ()<UIAlertViewDelegate>
@property (nonatomic,weak)UIButton *selected;

@property (nonatomic,weak)UIButton *chose;

@end

@implementation LotteryPad




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.link.paused=NO;
    [self setUserInteractionEnabled:YES];
}

-(instancetype)init{
    if(self=[super init]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.layer.contents=(__bridge id)[[UIImage imageNamed:@"LuckyRotateWheel"]CGImage];
    UIImage* img=[UIImage imageNamed:@"LuckyAstrology"];
    UIImage *pres=[UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    for(int i=0;i<COUNT;i++){
        UIButton *btn=[[UIButton alloc] init];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds=(CGRect){0,0,[UIImage imageNamed:@"LuckyRototeSelected"].size};
         btn.layer.anchorPoint=(CGPoint){0.5,1};
        [btn setImage:[self imageWithImg:img andIdx:i] forState:UIControlStateNormal];
        [btn setImage:[self imageWithImg:pres andIdx:i] forState:UIControlStateSelected];
       [ btn setImageEdgeInsets:(UIEdgeInsets){0,0,35,0}];
        btn.tag=i;
    }
    UIButton *chose=[[UIButton alloc] init];
    self.chose=chose;
    [self addSubview:chose];
    [chose setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
    [chose setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
    chose.bounds=(CGRect){0,0,[UIImage imageNamed:@"LuckyCenterButton"].size};
    [chose addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.chose){
        if(!self.selected){
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"alert" message:@"chose one" delegate:0 cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [aler show];
        }else if(![self.layer animationForKey:@"key"]){
            CABasicAnimation *ba=[[CABasicAnimation alloc] init];
            ba.keyPath=@"transform.rotation";
            ba.toValue=@(10*M_PI-self.selected.tag*M_PI*2/COUNT);
            [ba setRemovedOnCompletion:NO];
            [ba setFillMode:kCAFillModeForwards];
            ba.duration=3;
            [self.layer addAnimation:ba forKey:@"key"];
            self.link.paused=YES;
            [self setUserInteractionEnabled:NO];
            dispatch_after(dispatch_time(0, ba.duration*1e9), dispatch_get_main_queue(), ^{
                [self.layer removeAnimationForKey:@"key"];
                self.transform=CGAffineTransformMakeRotation([ba.toValue doubleValue]);
                UIAlertView *alerv=[[UIAlertView alloc] initWithTitle:@"alert" message:@"XXXXX" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alerv show];
                
            }) ;
        }
    }else if(sender==_link){
        self.transform=CGAffineTransformRotate(self.transform, M_PI/60/5);
    }else{
        [self.selected setSelected:NO];
        self.selected=sender;
        [self.selected setSelected:YES];
    }
}



-(CADisplayLink *)link{
    if(!_link){
        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(onBtnClicked:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center= {self.bounds.size.width*.5,self.bounds.size.width*.5};
    CGFloat gap=2*M_PI/COUNT;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=obj;
        
        btn.center=center;
        btn.transform=CGAffineTransformMakeRotation(idx*gap);
    }];

    self.chose.center=center;

    
    static int i=0;
    NSLog(@"pd=+====%d",i++);
    
}

-(UIImage *)imageWithImg:(UIImage *)img andIdx:(NSInteger)idx{
    CGFloat h=img.size.height*[UIScreen mainScreen].scale,
    w=img.size.width/COUNT*[UIScreen mainScreen].scale,
    x=idx*w,y=0;

    return [UIImage imageWithCGImage: CGImageCreateWithImageInRect(img.CGImage, (CGRect){x,y,w,h}) scale:2 orientation:0];

}

@end
