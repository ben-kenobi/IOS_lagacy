//
//  YFView.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView.h"
#import "Masonry.h"
#import "DrawPad.h"
@interface YFView ()
{
    CGContextRef context;
    CGRect rect;
}
@property (nonatomic,weak)UISlider *slider;
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,weak)DrawPad *pad;

@end

@implementation YFView


-(instancetype)init{
    if(self=[super init]){
        UISlider *slider=[[UISlider alloc] initWithFrame:(CGRect){50,500,250,30}] ;
        [self addSubview:slider];
        self.slider=slider;
        [self.slider addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *lab=[[UILabel alloc] init];
        [lab setTextColor:[UIColor whiteColor]];
        [self addSubview:lab];
        self.lab=lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];

       
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        DrawPad *pad=[[DrawPad alloc] initWithFrame:(CGRect){5,5,50,50}];
        [pad setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:pad];
        self.pad=pad;
        
        UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){60,60,100,100}];
        [btn setBackgroundColor:[UIColor redColor]];
        [self addSubview:btn];
        
        
    }
    return self;
}

-(void)onChange:(id)sender{
    if(sender==self.slider){
        [self setNeedsDisplay];
        [self.lab setText:[NSString stringWithFormat:@"%.2f%%",self.slider.value]];
    }
}


- (void)drawRect:(CGRect)rect {
    context=UIGraphicsGetCurrentContext();
    self->rect=rect;
    [self test];
    
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"subview222222222");
    return [super hitTest:point withEvent:event];
}


-(UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"22222222000000");
    [self setNeedsDisplayInRect:(CGRect){100,200,200,200}];
}

-(void)test{
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    CGContextMoveToPoint(context, self.center.x, self.center.y);
    CGFloat flo=self.slider.value;
    CGContextAddArc(context, self.center.x, self.center.y, 100, -M_PI_2, 2*M_PI*flo-M_PI_2, NO);
    CGContextFillPath(context);
}

-(void)test12{
    CGContextSetRGBFillColor(context, .5, .2, .2, 1);
    
    
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, 0, self.center.x, self.center.y);
    CGPathAddArc(path, 0, self.center.x, self.center.y, 100, 0, 1.5*M_PI, NO);
    CGContextAddPath(context, path);
   CGContextFillPath(context);
    CGPathMoveToPoint(path, 0, self.center.x, self.center.y);
    CGPathAddArc(path, 0, self.center.x, self.center.y,50 , M_PI, 1.8*M_PI, YES);

    
    CGContextSetRGBFillColor(context, .1, .2, .6, 1);
    
   
    CGContextAddPath(context, path);
    
    CGContextFillPath(context);
}
-(void)test11{
    NSArray *ary=@[@.3,@.4,@.2,@.1];
    
    CGFloat start=0,end=0;
    
    for(int i=0;i<ary.count;i++){
        end=M_PI*2*[ary[i] doubleValue]+start;
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, 150, start, end, NO);
        [[self randomColor] setFill];
        
        CGContextDrawPath(context, kCGPathFill);
        start=end;
    }
    
    
}


-(void)test10{
    CGContextSetRGBFillColor(context, .9, .6, .7, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 4);
    
    CGMutablePathRef path=CGPathCreateMutable();
    CGSize size=rect.size;
    CGFloat uwid=size.width*.1;
    CGPathAddEllipseInRect(path, 0, (CGRect){uwid,uwid*2,uwid*8,uwid*8});
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    path=CGPathCreateMutable();
    CGPathAddRect(path, 0, (CGRect){uwid*2,uwid*4,uwid*2,uwid});
    CGPathAddRect(path, 0, (CGRect){uwid*6,uwid*4,uwid*2,uwid});
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor(context, .9, .1, .1, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    path=CGPathCreateMutable();
    CGContextAddEllipseInRect(context, (CGRect){uwid*2.5,uwid*4,uwid,uwid});
    CGContextAddEllipseInRect(context, (CGRect){uwid*6.5,uwid*4,uwid,uwid});
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    path=CGPathCreateMutable();
//    CGPathMoveToPoint(path, 0, , <#CGFloat y#>)
    
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    
}

-(void)test9{
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    CGContextSetLineWidth(context, 15);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 200, 100);
    CGContextAddLineToPoint(context, 150, 20);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
-(void)test8{
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:(CGPoint){50,50}];
    [path addArcWithCenter:self.center radius:100 startAngle:M_PI_4 endAngle:M_PI clockwise:YES];
    [path setLineWidth:19];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path closePath];
    [[UIColor greenColor] setStroke];
     [[UIColor yellowColor] setFill];
    
    [path stroke];
    [path fill];

}

-(void)test7{
    [[UIBezierPath bezierPathWithArcCenter:self.center radius:100 startAngle:-M_PI_4 endAngle:M_PI_2 clockwise:NO] stroke];
}
-(void)test6{
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:130] stroke];
    [[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:(CGSize){30,50}] stroke];
    [[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft cornerRadii:(CGSize){110,110}] stroke];
}

-(void)test5{
//    CGContextSetLineWidth(context, 23);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
//    CGContextSetLineCap(context, kCGLineCapRound);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, 0, 0, 0);
    CGPathAddArc(path, 0, 100, 100, 50, M_PI_4, M_PI_2, YES);
    
    CGContextAddPath(context, path);

}

-(void)test4{
   
    CGMutablePathRef path1=CGPathCreateMutable();
    
    CGPathMoveToPoint(path1, 0, 30, 30);
    CGPathAddLineToPoint(path1, 0, 300, 300);
    CGPathAddLineToPoint(path1, 0, 30, 600);

    
    UIBezierPath *path2=[UIBezierPath bezierPathWithCGPath:path1];

    [path2 addLineToPoint:(CGPoint){30,300}];

    CGContextAddPath(context, [path2 CGPath]);

}

-(void)test3{
    UIBezierPath *path=[[UIBezierPath alloc] init];
    [path moveToPoint:(CGPoint){0,0}];
    [path addLineToPoint:(CGPoint){300,300}];
    CGContextAddPath(context, path.CGPath);
}

-(void)test2{
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, 0, 0, 0);
    CGPathAddLineToPoint(path, 0, 100, 100);
    CGContextAddPath(context, path);
    
}

-(void)test1{
   
    CGContextMoveToPoint(context, 50, 100);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 100, 150);
    CGContextAddLineToPoint(context, 150, 150);
    CGContextMoveToPoint(context, 190, 190);
    CGContextAddLineToPoint(context, 200, 250);
    CGContextAddEllipseInRect(context, (CGRect){50,50,100,100});
    
    CGContextAddCurveToPoint(context, .1, 1, .5, 2, 100, 300);
}


@end
