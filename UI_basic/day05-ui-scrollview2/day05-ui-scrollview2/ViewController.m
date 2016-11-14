//
//  ViewController.m
//  day05-ui-scrollview2
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define PAGES 5

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *sv;
@property (nonatomic,weak) UIImageView *iv;
@property (nonatomic,weak) UIPageControl *pc;
@property (nonatomic,weak) UITextView *txtV;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    
}


-(void) initState{
    [self startTimer];
}



-(void)startChangePage{
    self.pc.currentPage=(self.pc.currentPage+1)%PAGES;
        
    [self.sv setContentOffset:(CGPoint){self.sv.frame.size.width*self.pc.currentPage,0} animated:YES];
}


-(void)startTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startChangePage) userInfo:nil repeats:YES];
    NSRunLoop *loop=[NSRunLoop mainRunLoop];
    [loop addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma initUI
-(void)initUI{
    
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:(CGRect){0,15,self.view.frame.size.width,250}];
    sv.delegate=self;
    [sv setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:sv];
    self.sv = sv;
    [self.sv setMaximumZoomScale:2];
    [self.sv setMinimumZoomScale:.2];
    
    
    CGSize svSize=self.sv.frame.size;
    
    for(int i=0;i<PAGES;i++){
        UIImage *img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"img_%02d",i+1] ofType:@"png"]];
        UIImageView *iv=[[UIImageView alloc] initWithFrame:(CGRect){i*svSize.width,0,svSize}];
          [self.sv addSubview:iv];
        [iv setImage:img];
    }
    [self.sv setShowsHorizontalScrollIndicator:NO];
    [self.sv setContentSize:CGSizeMake(PAGES*svSize.width, 0)];
    [self.sv setPagingEnabled:YES];
    
    
    UIPageControl *pc=[[UIPageControl alloc] initWithFrame:(CGRect){svSize.width/2,svSize.height-10,0,0}];
    [pc setNumberOfPages:PAGES];
    [pc setCurrentPage:0];
    [pc setPageIndicatorTintColor:[UIColor grayColor]];
    [pc setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [pc setUserInteractionEnabled:NO];
    [self.view addSubview:pc];
    self.pc=pc;
    
    
    UITextView *tv=[[UITextView alloc] initWithFrame:(CGRect){50,CGRectGetMaxY(self.sv.frame),200,200}];
    tv.text=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mod.xml" ofType:nil] encoding:4 error:nil];
    [self.view addSubview:tv];
    self.txtV=tv;
    
}





-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
   
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pc.currentPage=scrollView.contentOffset.x/self.sv.frame.size.width;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.iv;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
@end



