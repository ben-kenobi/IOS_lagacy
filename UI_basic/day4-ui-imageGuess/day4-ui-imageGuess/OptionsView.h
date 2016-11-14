//
//  OptionsView.h
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMGussMod.h"
@protocol OptionsViewDelegate<NSObject>
-(void)onBtnClicked:(id)sender;
@end

@interface OptionsView : UIView


@property (nonatomic,weak) id<OptionsViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;
    
+(instancetype)viewWithFrame:(CGRect)frame count:(NSInteger)count;

-(void)updateOptsWithMod:(HMGussMod *)mod;

-(void)hideOpt:(NSString *)hid show:(NSString *)show;


@end
