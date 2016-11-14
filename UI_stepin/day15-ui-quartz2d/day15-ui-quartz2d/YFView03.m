//
//  YFView03.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView03.h"
#import "UIImage+Extension.h"
static int a=0;
@interface YFView03 ()
@property (nonatomic,strong)UIImage *img;
@property (nonatomic,assign)CGMutablePathRef path;
@property (nonatomic,assign)CGMutablePathRef path2;
@property (nonatomic,assign)CGContextRef con;
@end

@implementation YFView03

-(void)drawRect:(CGRect)rect{

    CGContextRef con=UIGraphicsGetCurrentContext();

    [[UIColor orangeColor] set];
    CGContextSetLineWidth(con, 5);
    CGContextAddPath(con, self.path);
    CGContextAddPath(con, self.path2);
    CGContextDrawPath(con, 2);
    
}

-(void)setImg:(UIImage *)img{
    _img=img;
    [self setNeedsDisplay];
}

-(CGMutablePathRef)path2{
    if(!_path2){
        _path2=CGPathCreateMutable();
    }
    return _path2;
}
-(CGMutablePathRef)path{
    if(!_path){
        _path=CGPathCreateMutable();
    }
    return _path;
}
-(CGContextRef)con{
    if(!_con){
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, 0, 0);
        _con=UIGraphicsGetCurrentContext();
    }
    return _con;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    int i=0;
   for(UITouch *touch in touches){
       
        CGPoint p=[touch locationInView:self];
        CGPoint p2=[touch previousLocationInView:self];
       if(i){
//        CGPathMoveToPoint(self.path, 0, p2.x, p2.y);
        CGPathAddLineToPoint(self.path, 0, p.x, p.y);
           
       }else{
//           CGPathMoveToPoint(self.path2, 0, p2.x, p2.y);
           CGPathAddLineToPoint(self.path2 , 0, p.x, p.y);
           i++;
           
       }
        [self setNeedsDisplay];
       
       CGContextDrawImage(self.con, self.bounds, [[UIImage imageNamed:@"me"] CGImage]);
       
       [[UIImage imageNamed:@"me"] drawAtPoint:(CGPoint){0,0}];
//        CGContextSetLineWidth(self.con, 10);
//        CGContextAddPath(self.con, self.path);
//        CGContextDrawPath(self.con, 2);
   }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    NSLog(@"$$$$$$$$$000000");
    int i=0;
    for(UITouch *touch in touches){
        
        CGPoint p=[touch locationInView:self];
        if(i){
            CGPathMoveToPoint(self.path, 0, p.x, p.y);
            
        }else{
            CGPathMoveToPoint(self.path2, 0, p.x, p.y);
            i++;
           
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"$$$$$$$$");
    return [super hitTest:point withEvent:event];
}
@end
