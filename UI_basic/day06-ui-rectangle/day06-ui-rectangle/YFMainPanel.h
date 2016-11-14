//
//  YFMainPanel.h
//  day06-ui-rectangle
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ROWCOUNT 22
#define COLCOUNT 14

@interface YFMainPanel : UIView

+(instancetype)panelWithFrame:(CGRect)frame;
-(void) initState;
-(BOOL)toggle;
-(void)moveHorizontal:(int)x;
-(void)rotate;
-(void)down;
@property (nonatomic,assign)BOOL stop;
@property (nonatomic,assign)NSTimeInterval interval;
@end
