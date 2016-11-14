//
//  YFLockV2.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFLockV2.h"
#define COUNT 9
#define  COL 3


@interface YFLockV2 ()

@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *sels;
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,assign)CGPoint curp;
@end

@implementation YFLockV2


-(NSMutableArray *)sels{
    if(!_sels){
        _sels=[NSMutableArray array];
    }
    return _sels;
}

- (void)drawRect:(CGRect)rect {
    [self.color setStroke];
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(con, 10);
    CGContextSetLineJoin(con, 1);
    CGContextSetLineCap(con, 1);
    for(int i=0;i<self.sels.count;i++){
        UIButton *btn=self.sels[i];
        if(i){
            CGContextAddLineToPoint(con, btn.center.x, btn.center.y);
        }else{
            CGContextMoveToPoint(con, btn.center.x, btn.center.y);
        }
    }
    if(self.sels.count)
        CGContextAddLineToPoint(con, self.curp.x, self.curp.y);
    
    CGContextDrawPath(con, 2);

}

-(void)addBtnToSelByTouches:(NSSet *)touches{
    UITouch *touch=[touches anyObject];
    CGPoint p=[touch locationInView:touch.view];
    for(NSInteger i=self.btns.count-1;i>=0;i--){
        UIButton *btn=self.btns[i];
        if(CGRectContainsPoint(btn.frame, p)){
            [btn setHighlighted:YES];
            if(![self.sels containsObject:btn])
                [self.sels addObject:btn];
            break;
        }
    }
    self.curp=p;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addBtnToSelByTouches:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
     [self addBtnToSelByTouches:touches];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curp =[(UIButton *)self.sels.lastObject center];
    [self setNeedsDisplay];
    [self setUserInteractionEnabled:NO];
    
    if(self.onLogin([self getPwd])){
        dispatch_after(dispatch_time(0, .3*1e9), dispatch_get_main_queue(), ^{
            [self initState];
        });
    }else{
        [self.sels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setSelected:YES];
            [obj setHighlighted:NO];
        }];
        self.color=[UIColor redColor];
        dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
            [self initState];
        });
    }
    if(self.comp)
        self.comp();
    
}
-(NSString *)getPwd{
    NSString *str=@"";
    for(UIButton *btn in self.sels){
        str=[NSString stringWithFormat:@"%@%ld",str,btn.tag];
    }
    return str;
}
-(void)setOnLogin:(BOOL (^)(NSString *))onLogin comp:(void (^)())comp{
    self.onLogin=onLogin;
    self.comp=comp;
}

-(void)initState{
    self.color =[UIColor cyanColor];
    [self.sels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
        [obj setHighlighted:NO];
    }];
    [self.sels removeAllObjects];
    [self setUserInteractionEnabled:YES];
    [self setNeedsDisplay];
}



-(UIColor *)color{
    if(!_color){
        _color=[UIColor cyanColor];
    }
    return _color;
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
        UIImage *img[3]={[UIImage imageNamed:@"gesture_node_normal"],[UIImage imageNamed:@"gesture_node_highlighted"],[UIImage imageNamed:@"gesture_node_error"]};
        int state[3]={ UIControlStateNormal, UIControlStateHighlighted ,UIControlStateSelected};
        for(int i=0;i<COUNT; i++){
            UIButton *btn=[[UIButton alloc] init];
            for(int i=0;i<3;i++){
                [btn setImage:img[i] forState:state[i]];
            }
            [btn sizeToFit];
            [btn setUserInteractionEnabled:NO];
            [self addSubview:btn];
            btn.tag=i;
            [self.btns addObject:btn];
        }
    }
    return _btns;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    UIButton *btn=self.btns.firstObject;
    CGFloat pad=(self.w-btn.w*COL)*.25;
    for(int i=0;i<COUNT;i++){
        int row=i/COL,col=i%COL;
        [_btns[i] setFrame:(CGRect){pad+(pad+btn.w)*col,pad+(pad+btn.h)*row,btn.size}];
    }

}

@end
