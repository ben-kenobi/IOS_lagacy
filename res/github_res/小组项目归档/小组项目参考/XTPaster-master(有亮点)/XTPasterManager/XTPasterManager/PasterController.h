//
//  PasterController.h
//  XTPasterManager
//
//  Created by TuTu on 15/10/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasterCtrllerDelegate <NSObject>
- (void)pasterAddFinished:(UIImage *)imageFinished ;
@end


@interface PasterController : UIViewController
@property (nonatomic,weak)   id <PasterCtrllerDelegate> delegate ;
@property (nonatomic,strong) UIImage *imageWillHandle ;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com