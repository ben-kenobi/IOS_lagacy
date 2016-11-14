//
//  PasterChooseView.h
//  subao
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasterChooseViewDelegate <NSObject>
- (void)pasterClick:(NSString *)paster ;
@end

@interface PasterChooseView : UIView
@property (nonatomic,weak)   id <PasterChooseViewDelegate> delegate ;
@property (nonatomic,copy)   NSString *aPaster ;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com