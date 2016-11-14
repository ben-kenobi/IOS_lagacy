//
//  YFShapeView.m
//  day06-ui-rectangle
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFShapeView.h"

#define SIZE {WID,WID}

static CGFloat WID;

static UIColor * COLOR;


@interface YFShapeView ()
{
    CGFloat originX,originY;

    @private
        UIView *views[4];
        CGPoint points[4];
    
}
@end


@implementation YFShapeView

-(CGPoint)pointsAt:(int)index{
    CGPoint p=points[index%4];
    p.x+=self.frame.origin.x;
    p.y+=self.frame.origin.y;
    return p;
}

-(void)setShape:(Shape)shape andDire:(int)dire{
    _shape=shape,_dire=dire;
    [self initShapeX:originX Y:originY];
}
-(void)setDire:(int)dire{
    _dire=dire;
    CGPoint po=self.frame.origin;
    [self initShapeX:po.x Y:po.y];
}

-(void)copyShape:(YFShapeView *)shap{
    _shape=shap.shape;
    _dire=shap.dire;
    for(int i=0;i<4;i++){
        points[i]=shap->points[i];
    }
    [self setFramesWithFrame:shap.frame];
}

-(void)setFramesWithFrame:(CGRect)frame{
    self.frame=frame;
    for(int i=0;i<4;i++){
        views[i].frame=(CGRect){points[i],SIZE};
    }
}


-(void)initShapeX:(CGFloat)x Y:(CGFloat)y{
    CGSize size;
    
    int wf,hf;
    switch(_shape){
        case Shape_I:
            wf=(_dire&1)?1:4;
            hf=(_dire&1)?4:1;
            size=CGSizeMake(WID*wf, WID*hf);
            break;
        case Shape_O:
            size=CGSizeMake(WID*2, WID*2);
            break;
        default:
            wf=(_dire&1)?2:3;
            hf=(_dire&1)?3:2;
           size=CGSizeMake(WID*wf, WID*hf);
    }
    
    CGRect frame={x,y,size};
    
    
    for(int i=0;i<4;i++){
        switch (_shape) {
            case Shape_I:
                points[i].x=i*WID*((_dire&1)!=1),points[i].y=(i*WID)*(_dire&1);
                break;
            case Shape_L:
                if(_dire==1)
                    points[i].x=(i==3)*WID,points[i].y=(i<3?i*WID:2*WID);
                else if(_dire==-1)
                    points[i].x=(i!=3)*WID,points[i].y=(i<3?i*WID:0*WID);
                else if(_dire==2)
                    points[i].x=(i<3?i*WID:2*WID),points[i].y=(i!=3)*WID;
                else if(_dire==-2)
                    points[i].x=(i<3?i*WID:0*WID),points[i].y=(i==3)*WID;
                break;
            case Shape_LR:
                if(_dire==1)
                    points[i].x=(i!=3)*WID,points[i].y=(i<3?i*WID:2*WID);
                else if(_dire==-1)
                    points[i].x=(i==3)*WID,points[i].y=(i<3?i*WID:0*WID);
                else if(_dire==2)
                    points[i].x=(i<3?i*WID:2*WID),points[i].y=(i==3)*WID;
                else if(_dire==-2)
                    points[i].x=(i<3?i*WID:0*WID),points[i].y=(i!=3)*WID;
                    
                break;
            case Shape_Z:
                if(_dire&1)
                    points[i].x=(i>>1)*WID,points[i].y=(i<3?i*WID:1*WID);
                else
                    points[i].x=(i<3?i*WID:1*WID),points[i].y=(i<2)*WID;
                break;
            case Shape_ZR:
                if(_dire&1)
                    points[i].x=(i<2)*WID,points[i].y=(i<3?i*WID:1*WID);
                else
                    points[i].x=(i<3?i*WID:1*WID),points[i].y=(i>=2)*WID;
                break;
            case Shape_O:
                points[i].x=(i%2)*WID,points[i].y=(i>>1)*WID;
                break;
                
        }
    }
    [self setFramesWithFrame:frame];

}








-(void)moveWithX:(int)x Y:(int)y{
    CGRect rect=self.frame;
    rect.origin.x+=x*WID;
    rect.origin.y+=y*WID;
    self.frame=rect;
}





-(instancetype)initShapeWithX:(int)x{
    if(self=[super init]){
        originX=x*WID;
        originY=0;
        for(int i=0;i<4;i++){
            views[i]=[self.class newCube];
            [self addSubview:views[i]];
        }
    }
    return self;
}


+(UIView *)newCube{
    UIView *cube= [[UIView alloc] init];
    [cube setBackgroundColor:COLOR];
    return cube;
}
+(instancetype)shapeWithX:(int)x{
    return [[self alloc] initShapeWithX:x];
}
+(void)setWid:(CGFloat)wid andColor:(UIColor *)color{
    WID=wid;
    COLOR=color;
}
+(CGFloat)wid{
    return WID;
}

@end
