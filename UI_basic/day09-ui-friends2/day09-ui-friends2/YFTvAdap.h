//
//  YFTvAdap.h
//  day09-ui-friends2
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface YFTvAdap : NSObject<UITableViewDelegate,UITableViewDataSource>

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv;

@end
