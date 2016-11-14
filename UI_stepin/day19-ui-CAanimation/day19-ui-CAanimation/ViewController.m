//
//  ViewController.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "LotteryPad.h"
#import "Masonry.h"
#import "YFWheel.h"
#import "UIColor+Extension.h"
#import "TestV.h"



CGMutablePathRef arcpath(CGFloat from,CGFloat x,CGFloat y,CGFloat rad);

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *layers;

//lottery
@property (nonatomic,weak)LotteryPad *lp;
@property (nonatomic,weak)YFWheel *wheel;
@property (nonatomic,weak)TestV *tv;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"wheel";
    [self initUI3];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)initUI4{
    TestV *tv=[[TestV alloc] init];
    [self.view addSubview:tv];
    self.tv=tv;
    self.tv.frame=(CGRect){100,100,100,100};
    [tv setBackgroundColor:[UIColor orangeColor]];
    
}


-(void)initUI3{
    [self.view.layer setContents:(__bridge id)[[UIImage imageNamed:@"LuckyBackground"]CGImage]];
    
    YFWheel *wheel=[[YFWheel alloc] init];
    self.wheel=wheel;
    [self.view addSubview:wheel];
    [wheel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(self.view.mas_width).multipliedBy(1);
    }];
    [wheel setBackgroundColor:[UIColor blackColor]];

}

-(void)initUI2{
    [self.view.layer setContents:(__bridge id)[[UIImage imageNamed:@"LuckyBackground"] CGImage]];
    LotteryPad *lp=[[LotteryPad alloc] init];

    self.lp=lp;
    [self.view addSubview:lp];
    [lp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.equalTo(self.view.mas_width).multipliedBy(.9);
    }];
    lp.link.paused=NO;
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGPoint p=self.view.center;
    for(int i=0;i<8;i++){
        CALayer *layer=[[CALayer alloc]init];
        layer.bounds=(CGRect){0,0,80,80};
        layer.cornerRadius=40;
        layer.position=p;
        layer.backgroundColor=[[UIColor orangeColor] CGColor];
        [self.view.layer addSublayer:layer];
        [self.layers addObject:layer];
    }

    
}





-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}

-(NSMutableArray *)layers{
    if(!_layers){
        _layers=[NSMutableArray array];
    }
    return _layers;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}



@end


CGMutablePathRef arcpath(CGFloat from,CGFloat x,CGFloat y,CGFloat rad){
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, 0, x, y);
    CGPathAddArc(path, 0, x, y, rad, from, from+2*M_PI, 0);
    CGPathAddLineToPoint(path, 0, x, y);
    return path;
}






