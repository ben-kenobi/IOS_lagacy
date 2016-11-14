//
//  YFView07.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView07.h"
#import "UIView+Ex.h"
static int cou=0;

@interface YFView07 ()
@property (nonatomic,assign)BOOL run;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation YFView07

-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
//    CGContextAddArc(con, 100, 100, 100, 0, 2*M_PI, 0);
    
//    CGContextClip(con);

    
//    CGContextAddArc(con, 150, 100, 100, 0, 2*M_PI, 0);
//    CGContextClip(con);
//    [[UIImage imageNamed:@"scene"] drawAtPoint:(CGPoint){0,0}];
    
    CGContextTranslateCTM(con, 0, self.h);
    CGContextScaleCTM(con, 1, -1);
    
    CGContextClipToMask(con, rect, [[UIImage imageNamed:@"main"] CGImage]);
   

    [[UIColor grayColor] set];
    
    CGContextSetLineWidth(con, 100);

    CGContextAddRect(con, rect);
    CGContextDrawPath(con, 2);

   

    
}

-(void)run:(id)sender{
    cou++;
    [self setNeedsDisplay];
    NSLog(@"%@---%d",[NSThread currentThread],self.run);
    [self.timer invalidate];
}
-(void)test{
    self.timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(run:) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    while (( [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]));
    NSLog(@"-----over");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    self.run=!self.run;

    
}


-(void)test13{
    CGFloat wid=100;
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGAffineTransform tran=CGAffineTransformMakeRotation(M_PI_4);
    CGPathAddRect(path, &tran, (CGRect){200,0,wid,wid});
    CGPathAddArc(path, &tran, 250, 0, wid*.5, 0, 2*M_PI, 0);
    CGPathAddArc(path, &tran, 200, 50, wid*.5, 0, 2*M_PI, 0);
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
}

-(void)test14{
    
    CGFloat wid=100;
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
     CGPathAddRect(path,0, (CGRect){(self.w-wid)*.5,(self.h-wid)*.5,wid,wid});
    CGContextAddRect(con, (CGRect){100,100,100,100});
    CGContextSaveGState(con);
    CGContextTranslateCTM(con, self.w*.5, self.h*.5);
    CGContextRotateCTM(con, M_PI_4);
    CGContextTranslateCTM(con, self.w*-.5, self.h*-.5);
    
    CGContextAddPath(con, path);
    CGContextRestoreGState(con);
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
}


@end
