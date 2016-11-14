//
//  UIView+Ex.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIView+Ex.h"

@implementation UIView (Ex)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)w{
    return self.frame.size.width;
}
-(void)setW:(CGFloat)w{
    CGRect frame=self.frame;
    frame.size.width=w;
    self.frame=frame;
}

-(CGFloat)h{
    return self.frame.size.height;
}
-(void)setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame.size.height=h;
    self.frame=frame;
}
-(CGPoint)innerCenter{
    return (CGPoint){self.w*.5,self.h*.5};
}


-(CGSize)size{
    return self.bounds.size;
}

-(void)setSize:(CGSize)size{
    CGRect bounds=self.bounds;
    bounds.size=size;
    self.bounds=bounds;
}


-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

@end
