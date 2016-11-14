//
//  YFSettingCon.h
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFSettingCon : UITableViewController

@property (nonatomic,copy)NSString *pname;
@property (nonatomic,strong)NSMutableArray *datas;
-(void)initUI;
-(void)onBtnClicked:(id)sender;
@end
