//
//  YFAlerV.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAlerV.h"



@implementation YFAlerV

-(void)drawRect:(CGRect)rect{
    NSDictionary *atts=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
     NSDictionary *atts2=@{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize titlesize=[self.title boundingRectWithSize:(CGSize){rect.size.width,20} options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:0].size;
    CGSize messize=[self.message boundingRectWithSize:(CGSize){rect.size.width,20} options:NSStringDrawingUsesLineFragmentOrigin attributes:atts2 context:0].size;
    
    CGFloat titleFrom=(rect.size.width-titlesize.width)*.5;
    CGFloat mesfrom=(rect.size.width-messize.width)*.5;
    
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(con, 10, 30);
    CGContextAddLineToPoint(con, rect.size.width-10, 30);
    [[UIColor grayColor]set];
    CGContextSetLineWidth(con, .2);
    CGContextDrawPath(con, 2);

   [ self.title drawAtPoint:(CGPoint){titleFrom,10} withAttributes:atts];
    [self.message drawAtPoint:(CGPoint){mesfrom,35} withAttributes:atts2];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    [self setNeedsDisplay];
}

-(void)setMessage:(NSString *)message{
    _message=message;
    [self setNeedsDisplay];
}
@end
