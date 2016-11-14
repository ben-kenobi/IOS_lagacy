//
//  YFChatTvAdap.h
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFChatTvAdap : NSObject<UITableViewDelegate,UITableViewDataSource>

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv;

-(void)addDatas:(NSArray *)datas;
@end
