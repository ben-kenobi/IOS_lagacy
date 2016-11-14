//
//  HMSV.m
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMSV.h"
#import "YFCate.h"


#define  wid 80

@interface HMSV ()
@property (nonatomic,strong)NSMutableArray *cells;

@property (nonatomic,weak)UIView *curV;
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,weak)UILongPressGestureRecognizer* reg;
@end

@implementation HMSV


-(NSMutableArray *)cells{
    if(!_cells){
        _cells=[NSMutableArray array];
        for(int i=0;i<self.count;i++){
            [self addView];
            
        }
    }
    return _cells;
}

-(void)tap:(id)sender{
    [self removeBtn:[sender view]];
}

-(void)lp:(UILongPressGestureRecognizer *)sender{
    self.reg=sender;
    self.curV=[sender view];
     [self bringSubviewToFront:self.curV];
    [UIView animateWithDuration:.25 animations:^{
        self.curV.transform=CGAffineTransformMakeScale(1.5, 1.5);
        self.curV.alpha=.6;
        [self.curV setBackgroundColor:[UIColor colorWithRed:.8 green:.3 blue:.3 alpha:1]];
    }];
    [sender setEnabled:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.curV){
        UITouch *touch=[touches anyObject];
        CGPoint p=[touch locationInView:self];
        self.curV.center=p;
        
        [self.cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if((obj!=self.curV)&&CGRectContainsPoint([obj frame], p)){
                [self.cells removeObject:self.curV];
                [self.cells insertObject:self.curV atIndex:idx];
                *stop=YES;
                [self layoutAnima];
            }
        }];
        
    }

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.curV.transform=CGAffineTransformIdentity;
    self.curV.alpha=1;
    self.curV.backgroundColor=[UIColor redColor];
    self.curV=0;
    self.reg.enabled=YES;
    [self layoutAnima];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(!_flag)
        [self layoutNormal];
    _flag=1;
   
}
-(void)layoutNormal{
    CGFloat gap=(self.w-wid*3)*.25;
    for(int i=0;i<self.cells.count;i++){
        UILabel *btn=self.cells[i];
        int row=i/3,col=i%3;
        if(btn!=self.curV){
            btn.x=(gap+wid)*col+gap;
            btn.y=(gap+wid)*row+gap;
        }
        btn.text=[NSString stringWithFormat:@"%d",i];
    }
    self.contentSize=(CGSize){0,CGRectGetMaxY([self.cells.lastObject frame])};
}
-(void)layoutAnima{
    [UIView animateWithDuration:.3 animations:^{
        [self layoutNormal];
    }];
}
-(void)removeBtn:(id)sender{
    [self.cells removeObject:sender];
    [sender removeFromSuperview];
    [self layoutAnima];
    
}
-(void)addView{
    UILabel *v=[[UILabel alloc] initWithFrame:(CGRect){0,0,wid,wid}];
    v.backgroundColor=[UIColor redColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [v setTextAlignment:NSTextAlignmentCenter];
    [v setTextColor:[UIColor whiteColor]];
    UILongPressGestureRecognizer *lp=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lp:)];
    [_cells addObject:v];
    [self addSubview:v];
    [v setUserInteractionEnabled:YES];
    [v addGestureRecognizer:tap];
    [v addGestureRecognizer:lp];
    [self layoutNormal];
}

-(instancetype)initWithCellCount:(NSInteger)count{
    if(self=[super init]){
        self.count=count;

    }
    return self;
}

@end
