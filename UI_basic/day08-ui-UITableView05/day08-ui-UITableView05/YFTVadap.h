//
//  YFTVadap.h
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTVadap : NSObject<UITableViewDelegate,UITableViewDataSource>

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv;
-(void)addDatas:(NSArray *)datas;
@end
