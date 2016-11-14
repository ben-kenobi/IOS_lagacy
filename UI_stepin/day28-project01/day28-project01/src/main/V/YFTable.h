//
//  YFTable.h
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTable : UITableView

@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,strong)NSMutableArray *infos;
@property (nonatomic,assign)BOOL confirm;

@end
