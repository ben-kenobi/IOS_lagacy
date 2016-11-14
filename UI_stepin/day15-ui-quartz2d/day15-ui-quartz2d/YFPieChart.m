//
//  YFPieChart.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFPieChart.h"
#import "UIColor+Extension.h"
@interface YFPieChart ()

@property (nonatomic,assign)CGFloat all;

@end

@implementation YFPieChart



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self setNeedsDisplay];
}


-(void)setDatas:(NSArray *)datas{
    _datas=datas;
    _all=0;
    [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        _all+=[obj doubleValue];
    }];
    
    [self setNeedsDisplay];
    
}
-(void)drawRect:(CGRect)rect{
    
    CGContextRef c= UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(c, 0, 0, 0, 1);
    CGContextSetLineWidth(c, 2);
    CGFloat start=0,end=0;
    for(id obj in self.datas){
        end=([obj doubleValue]/_all)*M_PI*2+start;
        [[UIColor randomColor] setFill];
        CGContextMoveToPoint(c, self.center.x, self.center.y);
        CGContextAddArc(c, self.center.x, self.center.y, MIN(self.center.x,self.center.y)*.9, start, end, NO);
        CGContextDrawPath(c, kCGPathFill);
        start=end;
    }
    
    
}






@end
