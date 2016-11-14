//
//  YFControlBoard.m
//  day02-ui-snake
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFControlBoard.h"

#define BTNSIZE 50


@interface YFControlBoard ()
{
    BOOL direc,pause,restart ;
    CGFloat btnLen;
}


@end

@implementation YFControlBoard



-(instancetype)initWithFrame:(CGRect)frame direc:(BOOL)direc_ pause:(BOOL)pause_ restart:(BOOL)restart_{
    if(self=[super initWithFrame:frame]){
        self->direc=direc_;
        self->pause=pause_;
        self->restart=restart_;
        btnLen=50;
        [self initUI];
        
    }
    return self;
}
+(instancetype)boardWithFrame:(CGRect)frame direc:(BOOL)direc pause:(BOOL)pause restart:(BOOL)restart{
    return [[self alloc] initWithFrame:frame direc:direc pause:pause restart:restart];
}




-(void)updateBtn:(BOOL)stop{
    UIButton *paus=(UIButton *)[self viewWithTag:Oper_Pause];
    if(stop){
        [paus setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateNormal];
        [paus setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateHighlighted];
    }else{
        [paus setBackgroundImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
        [paus setBackgroundImage:[UIImage imageNamed:@"minus_highlighted"] forState:UIControlStateHighlighted];
    }
    ((UIButton *)[self viewWithTag:1]).enabled=!stop;
    ((UIButton *)[self viewWithTag:-1]).enabled=!stop;
    ((UIButton *)[self viewWithTag:2]).enabled=!stop;
    ((UIButton *)[self viewWithTag:-2]).enabled=!stop;
    
}
-(void)initState{
    [((UIButton *)[self viewWithTag:Oper_Restart]) setEnabled:YES];
    [self updateBtn:NO];
}


-(void)initUI{
    
    int i;
    NSString *img[][2]={
        {@"top_normal",@"top_highlighted"},
        {@"bottom_normal",@"bottom_highlighted"},
        {@"left_normal",@"left_highlighted"},
        {@"right_normal",@"right_highlighted"},
        {@"right_highlighted",@"right_normal"},
        {@"minus_normal",@"minus_highlighted"},
    };
    CGSize size=self.frame.size;
    CGFloat gap=(size.height-2*BTNSIZE-20)/2;
    CGFloat delta=(BTNSIZE+20)/2;
    CGRect pos[]={
         {gap+delta,gap,BTNSIZE,BTNSIZE},
        {gap+delta,gap+delta*2,BTNSIZE,BTNSIZE},
       {gap,gap+delta,BTNSIZE,BTNSIZE},
        {gap+delta*2,gap+delta,BTNSIZE,BTNSIZE},
        {size.width-BTNSIZE*2-40,size.height/2,BTNSIZE,BTNSIZE},
        {size.width-BTNSIZE-20,size.height/2,BTNSIZE,BTNSIZE}
    };
    
    UIButton *(^createBtn)(CGRect,NSString*,NSString*,int,UIView*)=
    ^(CGRect fra,NSString*img,NSString *hlimg,int tag,UIView *supV){
        
        UIButton *b=[[UIButton alloc] initWithFrame:fra] ;
        [b setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [b setBackgroundImage:[UIImage imageNamed:hlimg] forState:UIControlStateHighlighted];
        b.tag=tag;
        [b addTarget:_delegate action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
        [supV addSubview:b];
        return b;
        
    };
    int tags[]={Oper_Up,Oper_Down,Oper_Left,Oper_Right,Oper_Pause,Oper_Restart};
   
       
    if(self->direc){
        for(i=0;i<4;i++){
             createBtn(pos[i] ,img[i][0] ,img[i][1] ,tags[i] ,self);
        }
    }
    if(self->pause){
        createBtn(pos[4] ,img[4][0] ,img[4][1] ,tags[4] ,self);

    }
    if(self->restart){
        createBtn(pos[5] ,img[5][0] ,img[5][1] ,tags[5] ,self);

    }
}


@end
