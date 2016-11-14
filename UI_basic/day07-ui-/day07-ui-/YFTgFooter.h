//
//  YFTgFooter.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFTgFooter;
@protocol YFTgFooterDelegate <NSObject>

-(void)loadMoreDidClicked:(YFTgFooter *)footer;

@end

@interface YFTgFooter : UIView

@property (nonatomic,weak)id<YFTgFooterDelegate>delegate;

+(instancetype)footerWithFrame:(CGRect)frame andTv:(UITableView *)tv;

@end
