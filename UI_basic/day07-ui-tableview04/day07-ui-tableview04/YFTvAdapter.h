//
//  YFTvAdapter.h
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFTg;

@interface YFTvAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,weak) UITableView *tv;

+(instancetype)adapterWithData:(NSArray *)data tableView:(UITableView *)tv;
-(void)appendData:(NSArray *)datas;

@end
