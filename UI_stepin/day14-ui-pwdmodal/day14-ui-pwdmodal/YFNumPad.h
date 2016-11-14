//
//  YFNumPad.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFNumPadDelegate <NSObject>

-(void)onPadBtnClicked:(UIButton *)sender;

@end

@interface YFNumPad : UIView
@property (nonatomic,weak)id<YFNumPadDelegate> delegate;
+(instancetype)padWithDelegate:(id<YFNumPadDelegate>)delegate;

@end
