//
//  ViewController.m
//  day05-ui-scrollViewTest
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define IMGSIZE ((CGSize){150,150})

@interface ViewController ()<UIScrollViewDelegate>


@property (nonatomic,weak) UIScrollView *sv;
@property (nonatomic,weak) UIButton *topV;
@property (nonatomic,weak) UIView *bottomV;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    CGRect svrect=self.view.frame;
    svrect.origin.y+=15;
    svrect.size.height-=15;
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:svrect];
    [sv setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:sv];
    self.sv=sv;
    self.sv.delegate=self;
    
    int COL=2,row=0,col=0;
    int count=11;
    CGFloat gap=(self.sv.frame.size.width-COL*IMGSIZE.width)/(COL+1);
    for(int i=0;i<count;i++){
        row=i/COL;
        col=i%COL;
        UIButton *iv=[[UIButton alloc] initWithFrame:(CGRect){(gap+IMGSIZE.width)*col+gap,(gap+IMGSIZE.height)*row+gap,IMGSIZE}];
        iv.tag=i+1;
        [iv setImage:[UIImage imageNamed:@"finditem_hotpeople"] forState:UIControlStateNormal];
         [self.sv addSubview:iv];
    }
    
    UIImage *botimg=[UIImage imageNamed:@"finditem_iwannabehere"];
    UIButton *svBottom=[[UIButton alloc] initWithFrame:(CGRect){(self.sv.frame.size.width-botimg.size.width)/2,(row+1)*(gap+IMGSIZE.height)+gap,botimg.size}];
    [svBottom setImage:botimg forState:UIControlStateNormal];
    [self.sv addSubview:svBottom];
    
    [self.sv setContentSize:(CGSize){self.sv.frame.size.width,CGRectGetMaxY(svBottom.frame)+gap}];
    [self.sv setContentOffset:(CGPoint){0,-50}];
    [self.sv setContentInset:(UIEdgeInsets){50,0,50,0}];
    
    
    CGRect toprect={svrect.origin.x,svrect.origin.y,svrect.size.width,55};
    UIButton *topV=[[UIButton alloc] initWithFrame:toprect];
    [topV setBackgroundColor:[UIColor grayColor]];
    topV.alpha=.4;
    [topV setImage:[UIImage imageNamed:@"tab_relay_n"] forState:UIControlStateNormal];
    [self.view addSubview:topV];
    self.topV=topV;
    
    toprect.origin.y=CGRectGetMaxY(self.sv.frame)-toprect.size.height;
    UIView *botV=[[UIView alloc] initWithFrame:toprect];
    [botV setBackgroundColor:[UIColor grayColor]];
    botV.alpha=.4;
    [self.view addSubview:botV];
    self.bottomV=botV;
    
    int countIcon=5;
    CGFloat iconW=self.bottomV.frame.size.width/countIcon;
    CGFloat iconH=self.bottomV.frame.size.height;
    UIImage *imgs[]={[UIImage imageNamed:@"tab_home_h"],
        [UIImage imageNamed:@"tab_comment_h"],
        [UIImage imageNamed:@"tab_relay_h"],
        [UIImage imageNamed:@"tab_relay_h"],
        [UIImage imageNamed:@"tab_share_h"],
        [UIImage imageNamed:@"tab_more_h"]};
    for(int i=0;i<countIcon;i++){
        UIButton *ico=[[UIButton alloc] initWithFrame:(CGRect){i*iconW,0,iconW,iconH}];
        [ico setImage:imgs[i] forState:UIControlStateNormal];
        [self.bottomV addSubview:ico];
    }
    
}

-(void)onBtnClicked:(UIButton *)sender{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"---%@",NSStringFromCGPoint(scrollView.contentOffset));
}

@end
