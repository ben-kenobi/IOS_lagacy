//
//  YFTgFooter.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgFooter.h"

@interface YFTgFooter ()

@property (nonatomic,weak)UIButton *more;
@property (nonatomic,weak)UIActivityIndicatorView *indicator;

@end

@implementation YFTgFooter



+(instancetype)footerWithFrame:(CGRect)frame andTv:(UITableView *)tv{
    YFTgFooter *obj=[[self alloc] initWithFrame:frame];
    [tv setTableFooterView:obj];
    [obj initUI];
    [obj initListeners];
    return obj;
}

-(void)initUI{
    CGSize selfsize=self.frame.size;
    UIButton *more=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, selfsize.width-20, selfsize.height-10)];
    [more setBackgroundColor:[UIColor orangeColor]];
    [more setTitle:@"Load More" forState:UIControlStateNormal];
    [more setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [more setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    more.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    [self addSubview:more];
    self.more=more;
    
    UIView  *view=[[UIView alloc] initWithFrame:more.frame];
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center=(CGPoint){20,view.center.y};
    [indicator setColor:[UIColor orangeColor]];
    [indicator setHidesWhenStopped:YES];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:view.frame];
    lab.text=@"Loading..";
    [lab setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:indicator];
    [view addSubview:lab];
    [self addSubview:view];
    self.indicator=indicator;
    
    view.hidden=YES;
}

-(void) initListeners{
    [self.more addTarget:self action:@selector(onMoreDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onMoreDidClicked:(UIButton *)sender{
    _more.hidden=YES;
    [_indicator startAnimating ];
    [_indicator.superview  setHidden:NO];
    dispatch_after(dispatch_time(0, 2e9), dispatch_get_main_queue(), ^{
        [_delegate loadMoreDidClicked:self];
        _more.hidden=NO;
        [_indicator stopAnimating];
        [_indicator.superview setHidden:YES];
    });
}



@end
