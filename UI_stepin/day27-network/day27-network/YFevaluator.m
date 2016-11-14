//
//  YFevaluator.m
//  day27-network
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFevaluator.h"



@implementation YFevaluator


- (void)drawRect:(CGRect)rect {
    CGFloat gap=2,w=(rect.size.width-(self.count+1)*gap)/self.count,top=(rect.size.height-w)*.5;
    [self.color setFill];
    
    CGContextRef con=UIGraphicsGetCurrentContext();
    
    for(NSInteger i=0;i<self.count;i++){
        CGPoint p={gap+i*(w+gap),top};
        CGSize size={w,w};
        CGMutablePathRef path=shapePath((CGRect){p,size}, 5, 5, 2,-M_PI_2);
        CGContextAddPath(con, path);
    }
  
    CGContextClip(con);

    
    CGContextAddRect(con, (CGRect){0,0,rect.size.width*self.percent,rect.size.height});
    CGContextDrawPath(con, 0);
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p=[[touches anyObject] locationInView:self];
    [self setPercent:p.x/self.w ];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p=[[touches anyObject] locationInView:self];
    [self setPercent:p.x/self.w ];
}

-(void)setPercent:(CGFloat)percent{
    _percent= percent >1?1:percent<0?0:percent;
    if(self.unit>0){
        double count=self.count/self.unit;
        _percent=round(percent*count)/count;
    }
    [self setNeedsDisplay];
    self.layer.shadowColor=[[UIColor lightGrayColor] CGColor];
    self.layer.shadowOffset=(CGSize){1,1};
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius=2;
}

-(UIColor *)color{
    if(!_color){
        _color=[UIColor orangeColor] ;
        
    }
    return _color;
}

@end
