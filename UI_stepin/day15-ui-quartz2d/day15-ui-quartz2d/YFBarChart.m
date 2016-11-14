//
//  YFBarChart.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBarChart.h"
#import "UIColor+Extension.h"

@interface YFBarChart ()


@end

@implementation YFBarChart

-(void)setDatas:(NSArray *)datas{
    _datas=datas;
    
    
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(con, 2);
    CGFloat h=rect.size.height;
    CGFloat x=0,y,wid=rect.size.width/(_datas.count*2+1),hei;
    
    for(id obj in self.datas){
        x+=wid;
        hei=h*[obj doubleValue]/_max;
        y=h-hei;
        CGContextAddRect(con, (CGRect){x,y,wid,hei});
        [[UIColor randomColor] setFill];
        [[UIColor randomColor] setStroke];
        CGContextDrawPath(con, 1);
        x+=wid;
    }
}



@end
