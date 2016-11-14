//
//  YFIndicator.h
//  day30-newwork02
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFIndicator : UIView
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)CGSize dotsize;
@property (nonatomic,strong)UIColor *tintColor;
@property (nonatomic,strong)UIColor *strokeColor;
-(void)onchange:(CGFloat)f;
@end
