//
//  YFHeroTvAdapter.h
//  day06-ui-tableView3
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHeroTvAdapter : NSObject <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,weak) UITableView *tv;


+(instancetype)adapterWithTv:(UITableView *)tv adnData:(NSArray *)datas;
@end
