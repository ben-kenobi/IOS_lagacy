//
//  YFView05.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView05.h"

@interface YFView05 ()

@property (nonatomic,strong) NSArray *ary;


@end

@implementation YFView05


-(NSArray *)ary{
    if(!_ary){
        _ary=[NSArray arrayWithObjects:@"spark_magenta",@"spark_yellow",@"spark_blue",@"spark_cyan",@"spark_red",@"spark_green", nil];
        
    }
    return _ary;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addImgByTouchs:touches];
    
}

-(void)addImgByTouchs:(NSSet *)touches{
    for(UITouch *tou in touches){
        CGPoint p=[tou locationInView:self];
       
        UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.ary objectAtIndex:arc4random()%(self.ary.count)]]];
        iv.center=p;
        iv.alpha=1;
        [UIView animateWithDuration:2 delay:2 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:0 animations:^{
            iv.alpha=0;
        } completion:^(BOOL finished) {
            [iv removeFromSuperview];
        }];
        [self addSubview:iv];
       
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addImgByTouchs:touches];
}


@end
