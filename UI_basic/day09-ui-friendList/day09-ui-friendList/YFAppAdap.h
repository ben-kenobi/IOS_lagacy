//
//  YFAppAdap.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAppAdap : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;


+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv;

@end
