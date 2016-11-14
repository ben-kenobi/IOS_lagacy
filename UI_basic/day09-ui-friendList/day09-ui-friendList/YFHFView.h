//
//  YFHFView.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFFriListF;
@class YFHFView;

@protocol YFHFViewDelegate <NSObject>

-(void)toggleSection:(YFHFView *)hfv;

@end

@interface YFHFView : UITableViewHeaderFooterView
@property (nonatomic,strong) YFFriListF *listF;
@property (nonatomic,weak) id<YFHFViewDelegate> delegate;

+(instancetype)viewWithTv:(UITableView *)tv andListF:(YFFriListF *)listf
              andDelegate:(id<YFHFViewDelegate>)delegate;

@end
