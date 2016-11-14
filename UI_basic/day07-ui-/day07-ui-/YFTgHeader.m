//
//  YFTgHeader.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgHeader.h"
@interface YFTgHeader ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *sv;
@property (nonatomic,weak) UIPageControl *pc;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation YFTgHeader


-(void)startTimer{
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(rollImgs) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)rollImgs{
    
    NSInteger count= self.imgs.count;
    CGFloat wid=_sv.frame.size.width;
    NSInteger index=([_pc currentPage]+1)%count;
    [_pc setCurrentPage:index];
    [_sv setContentOffset:(CGPoint){index*wid,0} animated:YES];
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint ofs=scrollView.contentOffset;
    [_pc setCurrentPage: ofs.x/scrollView.frame.size.width ];
    [self startTimer];
}


-(void)appendImgs:(NSArray *)ary{
    NSInteger from = _imgs.count;
    [_imgs addObjectsFromArray:ary];
    NSInteger to=_imgs.count;
    CGFloat wid=_sv.frame.size.width;
    for(NSInteger i=from;i<to;i++){
        UIImageView *iv=[[UIImageView alloc] initWithFrame:(CGRect){i*wid,0,_sv.frame.size}];
        iv.image=[UIImage imageNamed:_imgs[i]];
        [_sv addSubview:iv];
    }
    [self.sv setContentSize:CGSizeMake(to*wid, 0)];
    [_pc setNumberOfPages:to];
    
}

+(instancetype)headerWithFrame:(CGRect)frame andImgs:(NSArray *)imgs andTv:(UITableView *)tv{
    return [[self alloc] initWithFrame:frame andImgs:imgs andTv:tv];
}


-(instancetype)initWithFrame:(CGRect)frame andImgs:(NSArray *)imgs andTv:(UITableView *)tv{
    if(self=[super initWithFrame:frame]){
        self.imgs=[NSMutableArray array];
        [tv setTableHeaderView:self];
        [self initUI];
        [self appendImgs:imgs];
        [self startTimer];
    }
    return self;
    
}

-(void)initUI{
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:self.frame];
    [self addSubview:sv];
    [sv setPagingEnabled:YES];
    [sv setShowsHorizontalScrollIndicator:NO];
    self.sv=sv;
    sv.delegate=self;
    
    UIPageControl *pc=[[UIPageControl alloc] init];
    pc.center=(CGPoint){self.center.x,self.center.y/3*5};
    [pc setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [pc setPageIndicatorTintColor:[UIColor grayColor]];
    [self addSubview:pc];
    [pc setUserInteractionEnabled:NO];
    self.pc=pc;
    
    
}
@end
