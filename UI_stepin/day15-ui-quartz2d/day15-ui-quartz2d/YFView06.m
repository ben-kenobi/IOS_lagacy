//
//  YFView06.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView06.h"

#define BtnCount 9
#define BtnColCount 3

@interface YFView06 ()
@property (nonatomic,strong)NSMutableArray *btnAry;
@property (nonatomic,strong)NSMutableArray *lineAry;
@property (nonatomic ,assign)CGPoint curp;

@end

@implementation YFView06



-(void)addLineBtnByTouches:(NSSet *)touches{
    for(UITouch *touch in touches){
        CGPoint p=[touch locationInView:self];
        [self.btnAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(CGRectContainsPoint([obj frame], p)){
                [obj setHighlighted:YES];
                if(![_lineAry containsObject:obj])
                   [_lineAry addObject:obj];
                *stop=YES;
            }
        }];
        self.curp=p;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addLineBtnByTouches:touches];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curp=[self.lineAry.lastObject center];
    [self setNeedsDisplay ];
    NSString *pwd=@"";
    for(int i=0;i<self.lineAry.count;i++){
        pwd=[NSString stringWithFormat:@"%@%ld",pwd,[self.lineAry[i] tag] ];
    }
    BOOL b=0;
    if(self.blockDelegate){
         b=self.blockDelegate(pwd);
    }
    if(b){
        [self resetScreen];
    }else{
       [self.lineAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           [obj setHighlighted:NO];
           [obj setSelected:YES];
       }];
        [self setUserInteractionEnabled:NO];
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
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addLineBtnByTouches:touches];
    
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineCap(con, 1);
    CGContextSetLineJoin(con, 1);
    CGContextSetLineWidth(con, 10);
    [[UIColor whiteColor] setStroke];
    [self.lineAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint p=[self.lineAry[idx] center];
        if(!idx){
            CGContextMoveToPoint(con, p.x, p.y);
        }else{
            CGContextAddLineToPoint(con, p.x, p.y);
        }
    }];
    if(self.lineAry.count)
        CGContextAddLineToPoint(con, self.curp.x, _curp.y);
    CGContextDrawPath(con, 2);
}

-(NSMutableArray *)btnAry{
    if(!_btnAry){
        _btnAry=[NSMutableArray array];
        for(int i=0;i<BtnCount;i++){
            UIButton *btn=[[UIButton alloc] init];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateSelected];
            [_btnAry addObject:btn];
            [self addSubview:btn];
            [btn setUserInteractionEnabled:NO];
            btn.tag=i;
        }
        
    }
    return _btnAry;
}
-(NSMutableArray *)lineAry{
    if(!_lineAry){
        _lineAry=[NSMutableArray array];
    }
    return _lineAry;
}
-(void)initUI{
    CGSize imgsize=[UIImage imageNamed:@"gesture_node_normal"].size;
    CGSize size=self.bounds.size;
    CGFloat gap=(size.width-imgsize.width*BtnColCount)/(BtnColCount+1);
    CGRect rect;int row,col;
    for(int i=0;i<BtnCount;i++){
        row=i/BtnColCount,col=i%BtnColCount;
        rect=(CGRect){col*(imgsize.width+gap)+gap,row*(imgsize.height+gap)+gap,imgsize};
        [self.btnAry[i] setFrame:rect];
    }
}
-(void)initState{
    for(UIButton *btn in self.btnAry){
        [btn setSelected:NO];
        [btn setHighlighted:NO];
    }
    [self.lineAry removeAllObjects];
}

-(void)layoutSubviews{
    [self initUI];
    [self initState];
}


@end
