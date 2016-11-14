//
//  YFTabB.h
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTabB : UIView

-(void)addBtnWithImg:(UIImage *)img selImg:(UIImage *)selImage;

@property (nonatomic,copy)void (^onBtnClickedAtIdx)(NSInteger idx);

@end
