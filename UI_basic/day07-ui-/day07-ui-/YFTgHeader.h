//
//  YFTgHeader.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTgHeader : UIView

@property (nonatomic,strong)NSMutableArray *imgs;

-(void)appendImgs:(NSArray *)ary;

+(instancetype)headerWithFrame:(CGRect)frame andImgs:(NSArray *)imgs andTv:(UITableView *)tv;

@end
