//
//  YFLockPad.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFLockPad.h"
#define  COUNT 9
#define COL 3


@interface YFLockPad ()
@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *selBtns;
@property (nonatomic,assign)CGPoint curp;
@property (nonatomic,strong)UIColor *color;

@property (nonatomic,copy)BOOL (^login)(NSString *pwd);
@property (nonatomic,copy)void (^comp)();

@end

@implementation YFLockPad

-(void)setOnLogin:(BOOL (^)(NSString *pwd))login comp:(void (^)())comp{
    self.login=login;
    self.comp=comp;
    
}

-(void)drawRect:(CGRect)rect{
    [self.color setStroke];
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(con, 10);
    CGContextSetLineJoin(con, 1);
    CGContextSetLineCap(con, 1);
    for(int i=0;i<self.selBtns.count;i++){
        UIButton *btn=self.selBtns[i];
        CGPoint p=[btn center];
        if(i){
            CGContextAddLineToPoint(con, p.x, p.y);
        }else{
            CGContextMoveToPoint(con, p.x, p.y);
        }
    }
    if(self.selBtns.count)
        CGContextAddLineToPoint(con, self.curp.x, self.curp.y);
    CGContextDrawPath(con, 2);
}


-(void)selBtnBy:(NSSet *)touches{
   UITouch *touch=[touches anyObject];
    CGPoint p= [touch locationInView:touch.view];
    for(int i=0;i<self.btns.count;i++){
        UIButton *btn=self.btns[i] ;
        if(CGRectContainsPoint([btn frame],p)){
            [btn setHighlighted:YES];
            if(![self.selBtns containsObject:btn]){
                [self.selBtns addObject:btn];
            }
            
            break;
        }
    }
    self.curp=p;
    [self setNeedsDisplay];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self selBtnBy:touches];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self selBtnBy:touches];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curp=[(UIButton *)self.selBtns.lastObject center];
    [self setNeedsDisplay];
    [self setUserInteractionEnabled:NO];
    if(!self.login([self getPwd])){
        self.color=[UIColor redColor];
        [self setNeedsDisplay];
        [self.selBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setSelected:YES];
            [obj setHighlighted:NO];
        }];
        self.comp();
        dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
            [self initState];
        });
    }
    
    
    

}

-(NSString *)getPwd{
    __block NSString *str=@"";
    [self.selBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       str= [NSString stringWithFormat:@"%@%ld",str, [obj tag]];
    }];
    return str;
}


-(NSMutableArray *)selBtns{
    if(!_selBtns){
        _selBtns=[NSMutableArray array];
    }
    return _selBtns;
}

-(NSMutableArray *)btns{
    if (!_btns) {
        _btns=[NSMutableArray array];
        UIImage *img[3]={[UIImage imageNamed:@"gesture_node_normal"],[UIImage imageNamed:@"gesture_node_highlighted"],[UIImage imageNamed:@"gesture_node_error"]};
        int state[3]={ UIControlStateNormal, UIControlStateHighlighted ,UIControlStateSelected};
        for(int i=0;i<COUNT;i++){
            UIButton *btn=[[UIButton alloc] init];
            for(int i=0;i<3;i++){
                [btn setImage:img[i] forState:state[i]];
            }
            [btn setUserInteractionEnabled:NO];
            [self addSubview:btn];
        
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(self.mas_right).multipliedBy((i%3+1)*.33333);
                
             
                make.bottom.equalTo(self.mas_bottom).multipliedBy((i/3+1)*.3333);
               
            }];
            btn.tag=i;
            [self.btns addObject:btn];

        }
    }
    return _btns;
}

-(void)initState{
    [self.selBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
        [obj setHighlighted:NO];
    }];
    [self.selBtns removeAllObjects];
    [self setUserInteractionEnabled:YES];
    [self setNeedsDisplay];
    self.color=[UIColor cyanColor];

    
}

-(void)initUI{
    [self btns];
}
-(instancetype)init{
    if(self =[super init]){
        [self initUI];
    }
    return self;
}

@end
