//
//  HMVC.m
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMVC.h"
#import "YFCate.h"

@interface HMVC ()

@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,assign)BOOL stop;
@property (nonatomic,assign)CGMutablePathRef path;
@property (nonatomic,assign)CGFloat from;
@property (nonatomic,strong)CADisplayLink *link;

@end

@implementation HMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"bg"]CGImage];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){30,50,80,30}];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn addTarget:self action:@selector(begin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fish0"]];
    NSMutableArray *ary=[NSMutableArray array];
    for(int i=0;i<10;i++){
        [ary addObject:[UIImage imageNamed:[NSString stringWithFormat:@"fish%d",i]]];
    }
    [self.view addSubview:iv];
    iv.animationImages=ary;
    [iv startAnimating];
    iv.center=(CGPoint){self.view.w*.5,self.view.h*.5-self.view.w*.4};
    self.iv=iv;
    _stop=YES;
   self.path= CGPathCreateMutable();
    _from=-M_PI_2;
    self.link.paused=YES;

}

-(CADisplayLink *)link{
    if(!_link){
        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(draw)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

-(void)draw{
    CGFloat to=_from-M_PI/120;
    CGPathAddArc(self.path, 0, self.view.center.x, self.view.center.y, self.view.center.x*.8, _from,to , 1);
    CGPoint p=CGPathGetCurrentPoint(self.path);
    self.iv.center=p;
    _from=to;
    
    self.iv.transform=CGAffineTransformRotate(self.iv.transform, -M_PI/120);
}

-(void)toggle{
    _stop=!_stop;
    [self.btn setTitle:_stop?@"开始":@"stop" forState:UIControlStateNormal];
    if(_stop){
        [self.iv.layer removeAnimationForKey:@"123"];
    }else{
        if(![self.iv.layer animationForKey:@"123"]){
            CAKeyframeAnimation *ka=[CAKeyframeAnimation animation];
            ka.keyPath=@"position";
            CABasicAnimation *ba=[CABasicAnimation animation];
            ba.keyPath=@"transform.rotation";
            ba.byValue=@(-2*M_PI);
            CGMutablePathRef path= CGPathCreateMutable();
            CGPathAddArc(path, 0, self.view.center.x, self.view.center.y, self.view.w*.4, -M_PI_2, -M_PI_2-2*M_PI, 1);
            ka.path=path;
            
            CAAnimationGroup *group=[CAAnimationGroup animation];
            group.animations=@[ka,ba];
            group.duration=5;
            group.repeatCount=NSIntegerMax;
            [group setFillMode:kCAFillModeForwards];
            [group setRemovedOnCompletion:NO];
            [self.iv.layer addAnimation:group forKey:@"123"];

            
        }
    }
    
}


-(void)begin:(id)sender{
    self.link.paused=!self.link.paused;
    [self.btn setTitle:self.link.paused?@"开始":@"stop" forState:UIControlStateNormal];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
