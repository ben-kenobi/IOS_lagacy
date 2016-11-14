//
//  YFProgress1.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
#import "Masonry.h"
#import "YFProgress1.h"
#import "UIColor+Extension.h"
@interface  YFProgress1()
@property (nonatomic,weak)UILabel *lab;

@end

@implementation YFProgress1


-(void) initUI{
    UILabel *lab=[[UILabel alloc] init];
    self.lab=lab;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [lab setTextColor:[UIColor whiteColor]];
    lab.text=@"0.00%";
}
-(instancetype)init{
    if(self=[super init]){
        [self initUI];
        
    }
    return self;
}


-(void)setPerc:(CGFloat)perc{
    _perc=perc;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    self.lab.text=[NSString stringWithFormat:@"%.2f%%",_perc];
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(con, 10);
    CGContextMoveToPoint(con, self.center.x, self.center.y);
    CGContextAddArc(con, self.center.x, self.center.y, MIN(self.center.x,self.center.y)*.9, 0-M_PI_2, 2*M_PI*_perc-M_PI_2, NO);
    [[UIColor orangeColor] setStroke];
    CGContextStrokePath(con);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


@end
