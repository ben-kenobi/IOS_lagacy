//
//  ViewController.m
//  day06-ui-scrollView3
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"


#define COLS 5
typedef UIView *(^comv)(CGRect);

@interface ViewController ()

@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)UIButton *add;
@property (nonatomic,strong) comv newComv;
@property (nonatomic,assign) CGFloat wid;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void) initUI{
    CGRect mr=self.view.frame;
    _wid=self.view.frame.size.width/COLS;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:(CGRect){0,0,mr.size.width,_wid*3}];
    [sv setBackgroundColor:[UIColor colorWithRed:.8 green:.7 blue:.7 alpha:1]];
    [self.view addSubview:sv];
    self.sv=sv;
    
    
    UIButton *add=[[UIButton alloc] initWithFrame:(CGRect){0,0,_wid,_wid}];
    [add setBackgroundColor:[UIColor yellowColor]];
    [add setTitle:@"add" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sv addSubview:add];
    
    self.newComv=^(CGRect fra){
        UIView *v=[[UIView alloc] initWithFrame:fra];
        NSTimeInterval it=[NSDate timeIntervalSinceReferenceDate];
        CGFloat red=((NSInteger)(it*1E2)%10)/10.0;
         CGFloat gre=((NSInteger)(it*1E3)%10)/10.0;
         CGFloat blu=((NSInteger)(it*1E4)%10)/10.0;
        [v setBackgroundColor:[UIColor colorWithRed:red green:gre blue:blu alpha:1]];
        return v;
    };
    
    [add addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)onBtnClick:(UIButton *)sender{
    UIView * v=self.newComv(sender.frame);
    [self.sv addSubview:v];
    CGPoint pos=sender.frame.origin;
    
    if(CGRectGetMaxX(sender.frame)>=(_wid*COLS)){
        pos.x=0,pos.y=pos.y+_wid;
    }else{
        pos.x=pos.x+_wid;
    }
    sender.frame=(CGRect){pos,sender.frame.size};
    
    [self newView:sender];
}

-(void)newView:(UIView *)v{
    
    CGFloat maxy=v.frame.origin.y+_wid;
    if(maxy>=self.sv.frame.size.height){
        [self.sv setContentSize:(CGSize){0,maxy}];
        [self.sv setContentOffset:(CGPoint){0,maxy-self.sv.frame.size.height} animated:YES];
    }
}

@end
