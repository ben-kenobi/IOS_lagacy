//
//  YFHomePop.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YFHomePopDS;

@interface YFHomePop : UIView
@property (nonatomic,weak)id<YFHomePopDS>delegate;
@end
@protocol YFHomePopDS <NSObject>



- (NSInteger)numberOfRows:(YFHomePop *)pop;

- (void)pop:(YFHomePop *)pop updateCell:(UITableViewCell *)cell atRow:(NSInteger)row;

- (NSArray *)pop:(YFHomePop *)pop subdataForRow:(NSInteger)row;

@optional



- (void)pop:(YFHomePop *)pop didSelectRow:(NSInteger)row;
- (void)pop:(YFHomePop *)pop didSelectSubRow:(NSInteger)subrow row:(NSInteger)row;

@end
