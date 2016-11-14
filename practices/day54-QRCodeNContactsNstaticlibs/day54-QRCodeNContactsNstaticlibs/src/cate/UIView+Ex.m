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

-(CGFloat)b{
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)r{
    return CGRectGetMaxX(self.frame);
}

-(void)setB:(CGFloat)b{
    self.y=b-self.h;
}
-(void)setR:(CGFloat)r{
    self.x=r-self.w;
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

-(CGFloat)cx{
    return self.center.x;
}

-(void)setCx:(CGFloat)cx{
    CGPoint center=self.center;
    center.x=cx;
    self.center=center;
}


-(CGFloat)cy{
    return self.center.y;
}

-(void)setCy:(CGFloat)cy{
    CGPoint center=self.center;
    center.y=cy;
    self.center=center;
}


-(CGFloat)icx{
    return self.innerCenter.x;
}



-(CGFloat)icy{
    return self.innerCenter.y;
}

-(void)setB2:(CGFloat )b{
    CGRect frame=self.frame;
    frame.size.height=b-frame.origin.y;
    self.frame=frame;
}
-(void)setR2:(CGFloat )r{
    CGRect frame=self.frame;
    frame.size.width=r-frame.origin.x;
    self.frame=frame;
}
-(void)setX2:(CGFloat )x{
    CGRect frame=self.frame;
    frame.size.width=frame.origin.x-x+frame.size.width;
    self.frame=frame;
}
-(void)setY2:(CGFloat )y{
    CGRect frame=self.frame;
    frame.size.height=frame.origin.y-y+frame.size.height;
    self.frame=frame;
}






UIView *layoutViewWithSize(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full,CGSize size){
    for(UIView *v in subs){
        v.size=size;
    }
    return layoutView(sup, subs, colNum, full);
}

UIView *layoutView(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full){
    if(!subs.count||!colNum) return 0;
    if(colNum>subs.count)
        colNum=subs.count;
    if([sup isKindOfClass:[UIScrollView class]]){
        UIView *content=[[UIView alloc] init];
        [sup addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
            make.width.equalTo(sup);
        }];
        sup=content;
        
    }
    
    UIView *lastv;
    NSInteger i;
    NSMutableArray *ary=[NSMutableArray arrayWithCapacity:colNum+1];
    NSMutableArray *vary=[NSMutableArray array];
    for( i=0;i<subs.count;i++){
        NSInteger row=i/colNum,col=i%colNum;
        if(ary.count<col+1){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastv?lastv.mas_right:@0);
                if(col)
                    make.width.equalTo([ary[col-1] mas_width]);
            }];
            [ary addObject:gap];
        }
        if((vary.count<row+1)){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastv?lastv.mas_bottom:@0);
                if(full&&row)
                    make.height.equalTo([vary[row-1] mas_height]);
                else if(!full)
                    make.height.equalTo([ary[0] mas_width]);
            }];
            [vary addObject:gap];
            
        }
        
        UIView *v=subs[i];
        [sup addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([ary[col] mas_right]);
            make.width.equalTo(@(v.w));
            make.height.equalTo(@(v.h));
            make.top.equalTo([vary[row] mas_bottom]);
        }];
        lastv=v;
        
        if(col==colNum-1&&ary.count<col+2){
            UIView *gap=[[UIView alloc] init];
            [sup addSubview:gap];
            [gap mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo([ary[col] mas_width]);
                make.right.equalTo(@0);
                make.left.equalTo(lastv.mas_right);
            }];
            [ary addObject:gap];
        }
    }
    if(full){
        UIView *gap=[[UIView alloc] init];
        [sup addSubview:gap];
        [gap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.top.equalTo(lastv.mas_bottom);
            make.height.equalTo([[vary lastObject] mas_height]);
        }];
        [vary addObject:gap];
        return gap;
    }
    
    [sup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(lastv.mas_bottom);
    }];
    return lastv;
    
    
}



@end
