//
//  UIView+Ex.h
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
UIView * layoutView(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full);
UIView * layoutViewWithSize(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full,CGSize size);

@interface UIView (Ex)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@property (nonatomic,assign)CGFloat b;
@property (nonatomic,assign)CGFloat r;
@property (nonatomic,assign)CGFloat cx;
@property (nonatomic,assign)CGFloat cy;
@property (nonatomic,assign,readonly)CGPoint innerCenter;
@property (nonatomic,assign,readonly)CGFloat icx;
@property (nonatomic,assign,readonly)CGFloat icy;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

-(void)setB2:(CGFloat )b;
-(void)setR2:(CGFloat )r;
-(void)setX2:(CGFloat )x;
-(void)setY2:(CGFloat )y;
@end
