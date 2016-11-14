//
//  YFShapeView.h
//  day06-ui-rectangle
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    Shape_I=1,
    Shape_L=2,
    Shape_LR=3,
    Shape_Z=4,
    Shape_ZR=5,
    Shape_O=6
    
}Shape;


@interface YFShapeView : UIView

@property (nonatomic,assign,readonly) Shape shape;
@property (nonatomic,assign) int dire;

-(void)moveWithX:(int)x Y:(int)y;
-(void)copyShape:(YFShapeView *)shap;
-(void)setShape:(Shape)shape andDire:(int)dire;
-(CGPoint)pointsAt:(int)index;
+(instancetype)shapeWithX:(int)x;
+(void)setWid:(CGFloat)wid andColor:(UIColor *)color;
+(CGFloat)wid;
+(UIView *)newCube;
@end
