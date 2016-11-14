//
//  YFRegionPop.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  YFRegion;

@interface YFRegionPop : UIViewController

@property (nonatomic,strong)NSArray *regions;
@property (nonatomic,weak)UIPopoverController *pop;
@property (nonatomic,copy)void (^onchange)(YFRegion *reg,NSInteger subrow);
@property (nonatomic,copy)void (^onCityChange)(NSString *name);

@end
