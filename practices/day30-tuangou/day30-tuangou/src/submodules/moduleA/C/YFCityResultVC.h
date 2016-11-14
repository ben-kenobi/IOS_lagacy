//
//  YFCityResultVC.h
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCityResultVC : UITableViewController
@property (nonatomic,copy)NSString *searchText;
@property (nonatomic,copy)void(^onchange)(NSString *name);
@end
