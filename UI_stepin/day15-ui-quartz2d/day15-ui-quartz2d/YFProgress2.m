//
//  YFProgress2.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFProgress2.h"
#import "UIColor+Extension.h"
#import "Masonry.h"

@interface YFProgress2()

@property (nonatomic,weak)UILabel *lab;
@end

@implementation YFProgress2



-(instancetype)init{
    if(self=[super init]){
        [self initUI];
    }
    return self;
        
}

-(void)initUI{
    UILabel *lab=[[UILabel alloc] init];
    self.lab=lab;
    [self addSubview:lab];
    [self.lab setTextColor:[UIColor orangeColor]];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [lab setText:@"0.00%"];
}

-(void)setPerc:(CGFloat)perc{
    _perc=perc;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [self.lab setText:[NSString stringWithFormat:@"%.2f%%",self.perc]];
    CGContextRef con=UIGraphicsGetCurrentContext();
    [[UIColor cyanColor] setFill];
    CGFloat rad=MIN(self.center.x,self.center.y)*.9;
    CGContextAddArc(con, self.center.x, self.center.y,rad, -(M_PI*_perc)+M_PI_2, (M_PI*_perc)+M_PI_2, NO);
    CGContextDrawPath(con, 0);
    [[UIColor randomColor]setStroke];
    [[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:.3] setFill];
    
    CGContextAddArc(con, self.center.x, self.center.y, rad, 0, 2*M_PI, NO);
    CGContextDrawPath(con, 3);
    
    
}

@end
