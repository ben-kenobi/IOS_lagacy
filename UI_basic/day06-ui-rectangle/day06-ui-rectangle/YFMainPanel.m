//
//  YFMainPanel.m
//  day06-ui-rectangle
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainPanel.h"
#import "YFShapeView.h"


static int dire[]={1,-2,0,2,-1};
@interface YFMainPanel ()

{
    UIView *heap[ROWCOUNT][COLCOUNT];

}


@property (nonatomic,strong)YFShapeView *cur;
@property (nonatomic,strong)YFShapeView *next;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation YFMainPanel



-(void) initState{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    self.interval=.3;
    [self addSubview:self.cur];
    [self goNext];
    _stop=YES;
    [self toggle];
    
}

-(void)setStop:(BOOL)stop{
    if(_stop!=stop){
        [self toggle];
    }
}

-(BOOL)toggle{
    _stop=!_stop;
    if(_stop){
        [self.timer invalidate];
    }else{
        [self doDrop];
        self.timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(doDrop) userInfo:nil repeats:YES];
        NSRunLoop *loop=[NSRunLoop mainRunLoop];
        [loop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _stop;
}
-(void) goNext{
    [self.cur copyShape:self.next];
    [self randomNextShape];
}

-(void)doDrop{
   
    if(_stop) return ;
    if(CGRectGetMaxY(self.cur.frame)>=CGRectGetMaxY(self.bounds)){
        [self addToHeap];
        [self goNext];
    }else
        [self.cur moveWithX:0 Y:1];
    
}
-(void)moveHorizontal:(int)x{
    if(_stop)return ;
    CGFloat maxx=CGRectGetMaxX(self.cur.frame);
    CGFloat minx=CGRectGetMinX(self.cur.frame);
    if(!((maxx>=self.bounds.size.width&&x>0)||(minx<=0&&x<0)))
           [self.cur moveWithX:x Y:0];
    
}

-(void)rotate{
    [_cur setDire:dire[(_cur.dire+2)]];
}


-(void) addToHeap{
    
    for(int i=0;i<4;i++){
        CGRect fram={[_cur pointsAt:i],YFShapeView.wid,YFShapeView.wid};
        UIView *v=[YFShapeView newCube];
        v.frame=fram;
        [self addSubview:v];
        
    }
}

-(BOOL)isHitObstacle{
    __block BOOL hit=NO;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v=obj;
        CGPoint p;
        CGPoint p2=v.frame.origin;
        for(int i=0;i<4;i++){
            p=[_cur pointsAt:i];
            if(CGPointEqualToPoint(p, p2)){
                *stop=YES;
                hit=YES;
            }
        }
    }];
    return hit;
}

-(void)down{
    for(int i=0;i<4;i++){
        
    }
}








-(instancetype)initWithFrame:(CGRect)frame{
    
    frame.size.width=COLCOUNT*YFShapeView.wid;
    frame.size.height=ROWCOUNT*YFShapeView.wid;
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}
+(instancetype)panelWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}



-(YFShapeView *)next{
    if(nil==_next){
        NSTimeInterval it=[NSDate timeIntervalSinceReferenceDate];
        Shape shap=(((NSInteger)(it*1E2))%Shape_O)+1;
        self.next=[YFShapeView shapeWithX:6];
        [_next setShape:shap andDire:1];
    }
    return _next;
}
-(YFShapeView *)cur{
    if(nil==_cur){
        
        self.cur=[YFShapeView shapeWithX:6];
        [self addSubview:_cur];
    }
    return _cur;
}

-(void)randomNextShape{
    NSTimeInterval it=[NSDate timeIntervalSinceReferenceDate];
    Shape shap=(((NSInteger)(it*1E3))%Shape_O)+1;
    [self.next setShape:shap andDire:1];
   
}

-(void)initUI{
   
    CGFloat width=self.frame.size.width,
    height=self.frame.size.height;
    
   
    int i;
    
    UIView *line;
    UIColor* lineColor=[UIColor colorWithRed:.3 green:.9 blue:.3 alpha:1];
    for(i=0;i<=ROWCOUNT;i++){
        line=[[UIView alloc] initWithFrame:(CGRect){0,i*YFShapeView.wid,width,1}];
        line.backgroundColor=lineColor;
        [self addSubview:line];
    }
    for(i=0;i<COLCOUNT;i++){
        line=[[UIView alloc] initWithFrame:(CGRect){i*YFShapeView.wid,0 ,1 ,height}];
        line.backgroundColor=lineColor;
        [self addSubview:line];
    }

}
@end
