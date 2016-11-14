//
//  ViewController.m
//  day01-ui-moveImage
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define gap 20
#define duration .5

typedef NS_ENUM(NSInteger, BtnOperType) {
    BtnOperType_up=1,
    BtnOperType_left=2,
    BtnOperType_right=3,
    BtnOperType_down=4,
    BtnOperType_enlarge=5,
    BtnOperType_shrink=6
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int i;
    CGFloat width=50,height=50,x=70,y=self.view.frame.size.height/2,delta=35;
    NSInteger states[4]={UIControlStateNormal,UIControlStateHighlighted,
    UIControlStateDisabled,UIControlStateSelected};
    NSString *imageAry[]={@"btn_01",@"btn_02", @"btn_01",@"btn_02"};
    UIButton *controler[6]={};
    NSString *btnImgAry[6][2]={{@"top_normal",@"top_highlighted"},
        {@"left_normal",@"left_highlighted"},
        {@"right_normal",@"right_highlighted"},
        {@"bottom_normal",@"bottom_highlighted"},
    {@"plus_normal",@"plus_highlighted"},
    {@"minus_normal",@"minus_highlighted"}};
    CGFloat posAry[6][2]={{x,y},{x-delta,y+delta},{x+delta,y+delta},{x,y+delta*2},{x+100,y+50},{x+170,y+50}};
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.tag=100;
    button.frame=(CGRect){0,0,100,100};
    for( i=0;i<4;i++){
        [button setBackgroundImage:[UIImage imageNamed:imageAry[i]] forState:states[i]];
    }
    [self.view addSubview:button];
    for(i=0;i<6;i++){
        controler[i]=[self createButtonWithFrame:(CGRect){posAry[i][0],posAry[i][1],width,height} andNormalImg:btnImgAry[i][0] andHLImg:btnImgAry[i][1] andTag:(i+1)];
        
        [self.view addSubview:controler[i]];
       
    }
    
    
}
-(UIButton *)createButtonWithFrame:(CGRect)rect andNormalImg:(NSString *)name1
                          andHLImg:(NSString *)name2 andTag:(NSInteger)tag{
    UIButton *b=[[UIButton alloc] initWithFrame:rect];
    [b setBackgroundImage:[UIImage imageNamed:name1] forState:UIControlStateNormal];
    [b setBackgroundImage:[UIImage imageNamed:name2] forState:UIControlStateHighlighted];
    b.tag=tag;
    [b addTarget:self action:@selector(operations:) forControlEvents:UIControlEventTouchUpInside ];
    return b;
}


-(void)operations:(UIButton *)button{
    NSInteger tag=button.tag;
    UIView *img=[self.view viewWithTag:100];
    CGRect bound = img.bounds;
    CGRect frame=img.frame;
    CGRect vf=[self.view frame];
    switch(tag){
        case BtnOperType_up:
            frame.origin.y=CGRectGetMinY(frame)-gap<CGRectGetMinY(vf)?
            CGRectGetMinY(vf):CGRectGetMinY(frame)-gap;
            img.frame=frame;
            break;
        case BtnOperType_left:
            frame.origin.x=CGRectGetMinX(frame)-gap<CGRectGetMinX(vf)?
            CGRectGetMinX(vf):CGRectGetMinX(frame)-gap;
            img.frame=frame;
            break;
        case BtnOperType_right:
            frame.origin.x=(CGRectGetMaxX(frame)+gap>CGRectGetMaxX(vf)?
                            CGRectGetMaxX(vf):CGRectGetMaxX(frame)+gap)-
                            frame.size.width;
            img.frame=frame;
            break;
        case BtnOperType_down:
            frame.origin.y=(CGRectGetMaxY(frame)+gap>CGRectGetMaxY(vf)?
            CGRectGetMaxY(vf):CGRectGetMaxY(frame)+gap)-frame.size.height;
            img.frame=frame;
            break;
        case BtnOperType_enlarge:
            bound.size.width+=gap;
            bound.size.height+=gap;
            img.bounds=bound;
            break;
        case BtnOperType_shrink:
            bound.size.width-=gap;
            bound.size.height-=gap;
            img.bounds=bound;
            break;
    }
    
}

@end
