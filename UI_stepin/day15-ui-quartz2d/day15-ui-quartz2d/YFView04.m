//
//  YFView04.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView04.h"

@interface YFView04 ()
@property (nonatomic,strong)NSMutableArray *ary;
@property (nonatomic,strong)NSMutableArray *lineary;
@property (nonatomic,assign) CGPoint curp;
@end
@implementation YFView04


-(NSMutableArray *)ary{
    if(!_ary){
        _ary=[NSMutableArray array];
        for(int i=0;i<9;i++){
            UIButton *btn=[[UIButton alloc] init];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateSelected];
            [btn setAdjustsImageWhenDisabled:NO];
            [btn setAdjustsImageWhenHighlighted:NO];
            [_ary addObject:btn];
            [self addSubview:btn];
            [btn setUserInteractionEnabled:NO];
            btn.tag=i;
        }
    }
    return _ary;
}

-(NSMutableArray *)lineary{
    if(!_lineary){
        _lineary=[NSMutableArray array];
    }
    return _lineary;
}

-(void)drawRect:(CGRect)rect{
    

    CGContextRef con=UIGraphicsGetCurrentContext();
 
    
    [self.lineary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint center=[obj center];
        if(!idx){
            
            CGContextMoveToPoint(con, center.x, center.y);
        }else{
            CGContextAddLineToPoint(con, center.x, center.y);
        }
    }];
    if(self.lineary.count)
        CGContextAddLineToPoint(con, _curp.x, _curp.y);
    
    [[UIColor whiteColor] set];
    CGContextSetLineCap(con, kCGLineCapRound);
    CGContextSetLineJoin(con, 1);
    CGContextSetLineWidth(con,9);
    
    CGContextDrawPath(con, 2);
    
}


-(void)initUI{
    int count=3;
    CGSize size=self.bounds.size;
    CGSize imgsize=[UIImage imageNamed:@"gesture_node_normal"].size;
    
    CGFloat gap= (size.width-imgsize.width*count)/(count+1);
    
    for(int i=0;i<self.ary.count;i++){
        UIButton *btn=_ary[i];
        btn.frame=(CGRect){gap+(i%count)*(gap+imgsize.width),gap+(i/count)*(gap+imgsize.height),imgsize};
    }
}
-(void)layoutSubviews{
    [self initUI];
    [self initState];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addBtnToLineByTouches:touches];
    
}
-(void)addBtnToLineByTouches:(NSSet *)touches{
    CGPoint p=[[touches anyObject] locationInView:self];
    [self.ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(CGRectContainsPoint([obj frame], p)){
            [obj setHighlighted:YES];
            if(![self.lineary containsObject:obj])
                [self.lineary addObject:obj];
            *stop=YES;
        }
        
    }];
    self.curp=p;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addBtnToLineByTouches:touches];
    [self setNeedsDisplay];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curp=[[_lineary lastObject] center];
    [self setNeedsDisplay];
     __block NSString *pwd=[NSString string];
    [self.lineary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        pwd=[pwd stringByAppendingString:[NSString stringWithFormat:@"%@",@([obj tag])]];
    }];
    BOOL b=0;
    if(self.delegateBlock)
         b=_delegateBlock(pwd);
    if(b){
        [self resetScreen];
    }else{
        [self.lineary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setHighlighted:NO];
            [obj setSelected:YES];
        }];
        [self setUserInteractionEnabled:0];
        dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
            [self resetScreen];
            [self setUserInteractionEnabled:YES];
        });
    }
  
}

-(void)resetScreen{
    [self initState];
    [self setNeedsDisplay];
}
-(void)initState{
    [self.ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setHighlighted:NO];
        [obj setSelected:NO];
        
    }];
    [self.lineary removeAllObjects];
    
}


@end
