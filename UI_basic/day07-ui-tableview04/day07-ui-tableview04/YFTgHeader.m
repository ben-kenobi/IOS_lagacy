//
//  YFTgHeader.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgHeader.h"

@interface YFTgHeader()





@end

@implementation YFTgHeader

-(void)awakeFromNib{
    CGRect rect=self.frame;
}

-(void)initUI:(id<UIScrollViewDelegate>)delegate{
    CGFloat len=self.frame.size.width,
    hei=self.frame.size.height;
    CGRect svframe=self.sv.frame;
    svframe.size.width=len;
    self.sv.frame=svframe;
    for(int i=0;i<5;i++){
        CGRect rect=CGRectMake(i*len, 0, len, hei);
        UIImageView *iv=[[UIImageView alloc] initWithFrame:rect];
        iv.image=[UIImage imageNamed:[NSString stringWithFormat:@"ad_%02d",i]];
        [self.sv addSubview:iv];
    }
    [_sv setContentSize:CGSizeMake(len*5, 0)];
    [_sv setPagingEnabled:YES];
    [_sv setShowsHorizontalScrollIndicator:NO];
    _sv.delegate=delegate;
    
    [self.pageIndi setUserInteractionEnabled:NO];
    [self.pageIndi setNumberOfPages:5];
    [self.pageIndi setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.pageIndi setPageIndicatorTintColor:[UIColor cyanColor]];
    [self.pageIndi setCurrentPage:0];

    
    [self initState];
}

-(void)initState{
    [self startTImer];
    
}

-(void)startTImer{
    self.timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(rollImg) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)rollImg{
    static int ind=1;
    CGFloat wid=_sv.frame.size.width;
    [self.sv setContentOffset:CGPointMake(wid*(ind++%5), 0) animated:YES];
    [self.pageIndi setCurrentPage:((int)([self.sv contentOffset].x/wid)+1)%5];
    
    

}



@end
