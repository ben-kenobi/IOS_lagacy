//
//  YFVideoTV02.h
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFVideoTV02 : UITableView
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)UIViewController *con;

-(void)setXMLData:(NSData *)data;
@end
