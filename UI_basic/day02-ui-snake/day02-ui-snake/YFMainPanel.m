//
//  YFMainPanel.m
//  day02-ui-snake
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainPanel.h"



static NSInteger LEN=10;
static UIColor * RED;
static CGSize SIZE={10,10};


@interface YFMainPanel()
{
    int maxX,maxY,minX,minY;
}
@property (nonatomic,strong) NSMutableArray *snake;

@property (nonatomic,strong) NSMutableArray *snacks;


@end

@implementation YFMainPanel


-(instancetype)initWithFrame:(CGRect)frame bg:(UIColor *)bgcolor{
    if(self=[super initWithFrame:frame]) {
        [self initUI];
        [self setBackgroundColor:bgcolor];
    }
    return self;
}

+(instancetype)viewWithFrame:(CGRect)frame bg:(UIColor *)bgcolor{
    
    return [[self alloc] initWithFrame:frame bg:bgcolor];
}


-(void)initUI{
    RED=[UIColor colorWithRed:.9 green:.2 blue:.1 alpha:1];
    CGFloat width=self.frame.size.width,
    height=self.frame.size.height;
    
    maxX=width/LEN;
    maxY=height/LEN;
    minX=0;
    minY=0;
    int i;
    
    UIView *line;
    UIColor* lineColor=[UIColor colorWithRed:.3 green:.9 blue:.3 alpha:1];
    for(i=0;i<=maxY;i++){
        line=[[UIView alloc] initWithFrame:(CGRect){0,i*LEN,width,1}];
        line.backgroundColor=lineColor;
        [self addSubview:line];
    }
    for(i=0;i<maxX;i++){
        line=[[UIView alloc] initWithFrame:(CGRect){i*LEN,0 ,1 ,height}];
        line.backgroundColor=lineColor;
        [self addSubview:line];
    }
    
}

-(void)initState{
    self.interval=.2;
    self.direct=1;
    self.stop=NO;
    self.score=0;
    [self initSnake:5];
    [self initSnacks:30];
    [self move:NO];
}

-(void)move:(BOOL)onStep{
    if(_stop)
        return;
    UIView *head=_snake.lastObject;
    CGPoint cen=head.center;
    switch(_direct) {
        case 1:
            cen.y+=LEN;
            break;
        case -1:
            cen.y-=LEN;
            break;
        case 2:
            cen.x+=LEN;
            break;
        case -2:
            cen.x-=LEN;
            break;
    }
    BOOL biteself=NO;
    if([self isHitObstacle:cen orBiteSelf:&biteself]){
        if(_snake.count==1||biteself){
            [_delegate gameOver];
            return;
        }
        UIView *tail=_snake[0];
        [_snake removeObjectAtIndex:0];
        [tail removeFromSuperview];
    }else{
        UIView *snack=[self eat:cen];
        if(snack){
            [_snake addObject:snack];
            [self scorePlus];
        }else{
            UIView *tail=_snake[0];
            [_snake removeObjectAtIndex:0];
            tail.center=cen;
            [_snake addObject:tail];
        }
    }
    
    if(!onStep&&!_stop)
        [self performSelector:@selector(move:) withObject:nil afterDelay:_interval];
    
}


-(UIView *)eat:(CGPoint)pos{
    UIView * v;
    for(NSInteger i=_snacks.count-1;i>=0;i--)
    {
        v=_snacks[i];
        if(CGPointEqualToPoint(v.center,pos)){
            [_snacks removeObjectAtIndex:i];
            UIView *newsnack=[self newSnack];
            [_snacks addObject:newsnack];
            return v;
        }
        
    }
    return 0;
}
-(BOOL)isHitObstacle:(CGPoint)pos orBiteSelf:(BOOL *)flag{
    UIView *v;
    for(NSInteger i=_snake.count-1;i>=0;i--){
        v=_snake[i];
        if(CGPointEqualToPoint(v.center, pos)){
            if(i==_snake.count-2){
                _direct=_lastDirect;
            }else{
                *flag=YES;
            }
            return YES;
        }
    }
    
    int x,y;
    x=pos.x;
    y=pos.y;
    return x>maxX*LEN||y>maxY*LEN||x<minX*LEN||y<minY*LEN;
}

-(void)setDirect:(NSInteger)direct{
    if(_direct==direct){
        [self move:YES];
    }else if(_direct+direct){
        _lastDirect=_direct;
        _direct=direct;
    }
}






-(void)initSnacks:(int)len {
    int i;
    for(i=0;i<self.snacks.count;i++){
        [((UIView *)self.snacks[i]) removeFromSuperview ];
    }
    self.snacks=[NSMutableArray array];
    for(i=0;i<len;i++){
        [_snacks addObject:[self newSnack]];
    }
}
-(void)initSnake:(int)len{
    int i;
    for(i=0;i<self.snake.count;i++){
        [((UIView *)self.snake[i]) removeFromSuperview ];
    }
    self.snake=[NSMutableArray array];
    for(i=0;i<len;i++){
        UIView *v=[self baseV:(CGPoint){0,i*LEN}];
        [self addSubview:v];
        [self.snake addObject:v];
    }
    
}
-(UIView *)newSnack{
    UIView *snack=[self baseV:[self newPoint]];
    [self addSubview:snack];
    return snack;
}
-(CGPoint)newPoint{
    CGPoint p={0,0};
    int x,y,i,flag;
    do{
        flag=0;
        NSTimeInterval it=[NSDate timeIntervalSinceReferenceDate];
        x=(NSInteger)(it*1E6)%maxX;
        y=(NSInteger)(it*1E7)%maxY;
        p.x=x*LEN;p.y=y*LEN;
        for( i=0;i<_snake.count&&!flag;i++)
            flag=CGPointEqualToPoint(p, ((UIView *)_snake[i]).frame.origin);
        for(i=0;i<_snacks.count&&!flag;i++)
            flag=CGPointEqualToPoint(p, ((UIView *)_snacks[i]).frame.origin);
    }while(flag);
    
    return p;
}

-(UIView *)baseV:(CGPoint)po{
    UIView *v=[[UIView alloc] initWithFrame:(CGRect){po,SIZE}];
    v.backgroundColor=RED;
    return v;
}

-(void)scorePlus{
    NSInteger delta=self.snake.count*10;
    self.score=_score+delta;
    
}
-(void)setScore:(NSInteger)score{
    _score=score;
    [self.delegate updateScore];
}
-(NSInteger)snakeLen{
    return _snake.count;
}



@end
