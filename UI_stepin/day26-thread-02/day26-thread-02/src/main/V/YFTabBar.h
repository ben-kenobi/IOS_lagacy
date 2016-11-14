//
//  YFTabBar.h
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTabBar : UIView

@property (nonatomic,copy)void(^onTabChange)(NSInteger idx);
-(void)selectAtIdx:(int)idx;
@end


@interface YFTabButton :UIButton

@end