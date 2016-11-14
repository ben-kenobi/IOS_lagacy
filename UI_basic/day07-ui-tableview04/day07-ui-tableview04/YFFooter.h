//
//  YFFooter.h
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFFooter;
@protocol YFFooterDelegate <NSObject>
@optional
-(void)loadMoreDidClicked:(YFFooter *)footer;

@end

@interface YFFooter : UIView

@property (nonatomic,assign)id<YFFooterDelegate> delegate;

-(void)initListener;
    



@end
