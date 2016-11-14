//
//  YFControlBoard.h
//  day02-ui-snake
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Oper_Up=-1,
    Oper_Down=1,
    Oper_Right=2,
    Oper_Left=-2,
    Oper_Pause=10,
    Oper_Restart=20
}OperateType;


@protocol ControlBoardDelegate <NSObject>
-(void)operate:(UIButton *)sender;
@end

@interface YFControlBoard : UIView

@property (nonatomic,weak) id<ControlBoardDelegate> delegate;



+(instancetype)boardWithFrame:(CGRect)frame direc:(BOOL)direc pause:(BOOL)pause restart:(BOOL)restart;
-(void)updateBtn:(BOOL)stop;
-(void)initState;
@end
