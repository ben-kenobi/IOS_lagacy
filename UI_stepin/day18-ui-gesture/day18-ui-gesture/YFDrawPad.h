//
//  YFDrawPad.h
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFDrawPad : UIView

@property (copy,nonatomic)CGFloat (^getWid)();
@property (strong,nonatomic)UIColor *linecolor;
@property (copy,nonatomic)UIColor *(^getColor)();
@property (assign,nonatomic)NSInteger es;
-(void)undo;
-(void)clear;
-(void)redo;

@end
