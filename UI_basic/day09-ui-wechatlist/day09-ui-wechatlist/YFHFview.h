//
//  YFHFview.h
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class YFFriendList,YFHFview;

@protocol HFVDelegate <NSObject>

@optional
-(void)toggleList:(YFHFview *)hfv;

@end

@interface YFHFview :UITableViewHeaderFooterView

@property (nonatomic,strong)YFFriendList *mod;
@property (nonatomic,weak) id<HFVDelegate>delegate;

@end
