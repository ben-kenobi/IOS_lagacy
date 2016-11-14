//
//  HMAnswerView.h
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMGussMod.h"

@protocol AnserViewDelegate <NSObject>

-(void)onBtnClicked:(id)sender;

@end

@interface HMAnswerView : UIView

@property (nonatomic,weak) id<AnserViewDelegate> delegate;
+(instancetype)viewWithFrame:(CGRect)frame;
-(void)updateAnserWithMod:(HMGussMod *)mod;
-(void)updateAnswerColor:(UIColor *)cl;
-(NSString *)addTitle:(NSString *)tit complete:(BOOL *)complete;
-(NSString *)tipByMod:(HMGussMod *)mod replaced:(NSString **)replaced complete:(BOOL *)complete;
@end
