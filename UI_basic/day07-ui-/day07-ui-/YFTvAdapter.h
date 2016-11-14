//
//  YFTvAdapter.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTvAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,weak) UITableView *tv;

+(instancetype)adapterWithDatas:(NSArray *)datas andTv:(UITableView *)tv;
-(NSInteger)loadMore:(NSArray *)data;

@end
