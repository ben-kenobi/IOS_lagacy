//
//  YFFooter.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFooter.h"


@interface YFFooter ()
@property (weak, nonatomic) IBOutlet UIButton *more;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end


@implementation YFFooter

-(void)initListener{
    [self.more addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onBtnClicked:(UIButton *)sender{
    if(sender==_more){
        _more.hidden=YES;
        _indicator.superview.hidden=NO;
        [_indicator startAnimating ];
        dispatch_after(dispatch_time((uint64_t)0, (int64_t)1000000000), dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector:@selector(loadMoreDidClicked:)])
                [_delegate loadMoreDidClicked:self];
            _more.hidden=NO;
            _indicator.superview.hidden=YES;
            [_indicator stopAnimating];
            
            
        });
        
        
        
    }
}

@end
