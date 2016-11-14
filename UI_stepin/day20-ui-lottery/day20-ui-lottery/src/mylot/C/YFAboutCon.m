//
//  YFAboutCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAboutCon.h"
#import "Masonry.h"
#import "YFCate.h"

@implementation YFAboutCon


-(void)initUI{
    [super initUI];
    UIView *header=[[UIView alloc] init];
    header.h=200;
    [header setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:header];
    
    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_logo"]];
    [header addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    
    UILabel *lab=[[UILabel alloc] init];
    lab.text=@"wijefoiwjeiofjiwejf";
    [header addSubview:lab];
    [lab setFont:[UIFont boldSystemFontOfSize:22]];
    [lab sizeToFit];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(iv.mas_bottom).offset(10);
    }];
    
    


    
    
}





@end
