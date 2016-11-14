//
//  YFPwdPad.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFPwdPadDelegate <NSObject>

-(void)onPwdChange:(NSString *)pwd full:(BOOL)full;
-(void)onCommit:(NSString *)pwd;


@end

@interface YFPwdPad : UIView

@property (nonatomic,weak)id<YFPwdPadDelegate>delegate;

@property (nonatomic,copy,readonly)NSMutableString *pwd;

+(instancetype)pwdPadWithLen:(NSInteger)len delegate:(id<YFPwdPadDelegate>)delegate;

-(void)append:(NSString *)str;
-(void)deleteLast;
-(void)initState;
@end
