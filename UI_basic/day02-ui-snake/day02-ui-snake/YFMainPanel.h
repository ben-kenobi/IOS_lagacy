//
//  YFMainPanel.h
//  day02-ui-snake
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BTNSIZE 40

@protocol YFMainPanelDelegate <NSObject>

-(void)gameOver;
-(void)updateScore;

@end

@interface YFMainPanel : UIView
@property (nonatomic,assign) NSInteger direct;
@property (nonatomic,assign) NSInteger lastDirect;
@property (nonatomic,assign) CGFloat interval;
@property (nonatomic,assign) BOOL stop;
@property (nonatomic,assign) NSInteger score;
@property (nonatomic,weak) id<YFMainPanelDelegate>delegate;
+(instancetype)viewWithFrame:(CGRect)frame bg:(UIColor *)bgcolor;
-(void)move:(BOOL)oneStep;
-(void)initSnacks:(int)len;
-(void)initSnake:(int)len;
-(NSInteger)snakeLen;
-(void)initState;
@end
