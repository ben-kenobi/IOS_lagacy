//
//  YFLockPad.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFLockPad.h"
#define BTNCOUNT 9
#define COLCOUNT 3

@interface YFLockPad ()
@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *touched;
@property (nonatomic,assign)CGPoint curp;
@property (nonatomic,strong) UIColor *color;
@property (copy,nonatomic)BOOL (^onfinish)(NSString *str);
@property (copy,nonatomic)void (^comp)();
@end

@implementation YFLockPad
-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineCap(con, 1);
    CGContextSetLineJoin(con, 1);
    CGContextSetLineWidth(con, 10);
    [self.color setStroke];
    [self.touched enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint center=[obj center];
        if(idx){
            CGContextAddLineToPoint(con, center.x, center.y);
        }else{
            CGContextMoveToPoint(con, center.x, center.y);
        }
    }];
    if(self.touched.count)
        CGContextAddLineToPoint(con, _curp.x, _curp.y);
    
    CGContextDrawPath(con, 2);
}

-(void)setOnfinish:(BOOL (^)(NSString *))onfinish complete:(void (^)())comp{
    self.onfinish=onfinish;
    self.comp=comp;
}

-(void)addBtnByTouches:(NSSet *)touches{
    UITouch *touch=[touches anyObject];
    CGPoint p=[touch locationInView:touch.view];
    self.curp=p;
    for(NSInteger i=self.btns.count-1;i>=0;i--){
        if(CGRectContainsPoint([self.btns[i] frame], p)&&![_touched containsObject:self.btns[i]]){
            [self.btns[i] setHighlighted:YES];
            [self.touched addObject:self.btns[i]];
        }
        
    }
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addBtnByTouches:touches];
}


-(NSString *)getPwd{
    __block NSString *pwd=@"";
    [self.touched enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        pwd=[pwd stringByAppendingString:[NSString stringWithFormat:@"%ld",[obj tag]]];
    }];
    return pwd;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curp=[self.touched.lastObject center];
    [self setNeedsDisplay];
    BOOL b= 0;
    if(self.onfinish){
        b=self.onfinish([self getPwd]);
    }
    if(!b){
        [self.touched enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setHighlighted:NO];
            [obj setSelected:YES];
        }];
        [self setColor:[UIColor redColor]];
        [self setNeedsDisplay];
        
    }
    
    [self setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:YES];
        [self initState];
    }) ;
    if(self.comp){
        self.comp();
    }

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addBtnByTouches:touches];
}


-(void)initState{
    [self.btns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setHighlighted:NO];
        [obj setSelected:NO];
    }];
    [self.touched removeAllObjects];
    [self setColor:[UIColor cyanColor]];
    [self setNeedsDisplay];
}


-(NSMutableArray *)touched{
    if(!_touched){
        _touched=[NSMutableArray array];
    }
    return _touched;
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
        UIButton *btn;
        UIImage *imgs[]={[UIImage imageNamed:@"gesture_node_normal"],[UIImage imageNamed:@"gesture_node_highlighted"],[UIImage imageNamed:@"gesture_node_error"]};
        NSInteger states[]={UIControlStateNormal,UIControlStateHighlighted,UIControlStateSelected};
        for(int i=0;i<BTNCOUNT;i++){
            btn=[[UIButton alloc] init];
            for(int i=0;i<sizeof(states)/sizeof(states[0]);i++)
                [btn setBackgroundImage:imgs[i] forState:states[i]];
            [btn setUserInteractionEnabled:NO];
            btn.tag=i;
            [self addSubview:btn];
            [_btns addObject:btn];
        }
    }
    return _btns;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size=self.bounds.size,btnsize=[UIImage imageNamed:@"gesture_node_normal"].size;
    CGFloat pad=(size.width-btnsize.width*COLCOUNT)*.25;
    UIButton *btn;
    int row,col;
    for(int i=0;i<BTNCOUNT;i++){
        btn=self.btns[i];
        row=i/COLCOUNT,col=i%COLCOUNT;
        btn.frame=(CGRect){pad+(pad+btnsize.width)*col,pad+(pad+btnsize.height)*row,btnsize};
    }
    [self initState];
}

@end
