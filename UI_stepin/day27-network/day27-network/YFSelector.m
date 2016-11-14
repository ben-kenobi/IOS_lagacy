//
//  YFSelector.m
//  day27-network
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSelector.h"

@implementation YFSelector




- (void)drawRect:(CGRect)rect {
    CGFloat cy=self.icy,cx=10,rad=7,irad=3.5;
 
    CGContextRef con=UIGraphicsGetCurrentContext();
    [[UIColor lightGrayColor] setStroke];
    CGContextAddArc(con, cx, cy, rad, 0, 2*M_PI, 0);
    CGContextSetLineWidth(con, 1.5);
    CGContextDrawPath(con, 2);
    
    CGSize size=[self.title boundingRectWithSize:(CGSize){rect.size.width-cx+rad*2,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:0].size;
    [self.title drawWithRect:(CGRect){cx+rad*2,rect.size.height-size.height<0?0:(rect.size.height-size.height)*.5,size} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:0];

    
   
    

    if(self.selected){
        CGContextAddArc(con, cx, cy, irad, 0, 2*M_PI, 0);
        [[UIColor greenColor] setFill];
        CGContextDrawPath(con, 0);
    }
}



-(void)setSelected:(BOOL)selected{
    _selected=selected;
    [self setNeedsDisplay];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    [self setNeedsDisplay];
}

@end
