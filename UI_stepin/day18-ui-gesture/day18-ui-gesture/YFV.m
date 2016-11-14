//
//  YFV.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFV.h"

@implementation YFV


-(void)setPath:(CGPathRef)path{
    _path=path;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
   
    
   
    [[UIColor redColor] set];
    _path =CGPathCreateMutable();
    CGPathAddArc(_path, 0, 200, 300, 100, 0, 2*M_PI, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(con, 2);
    CGContextAddPath(con, self.path);
    CGContextDrawImage(con, rect, [[UIImage imageNamed:@"scene"] CGImage]);
    CGContextDrawPath(con, 2);
    
}

@end
