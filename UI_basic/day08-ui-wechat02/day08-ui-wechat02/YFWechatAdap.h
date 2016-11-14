//
//  YFWechatAdap.h
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFWechatAdap : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong) NSMutableArray *datas;

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv;
-(void)appendDatas:(NSArray *)ary;

@end
