//
//  YFTVAdap.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTVAdap : NSObject <UITableViewDelegate,UITableViewDataSource>


+(instancetype)adapWithDatas:(NSArray *)ary tv:(UITableView *)tv;

@end
