//
//  YFTableCell.h
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFTableCellF;

@interface YFTableCell : UITableViewCell

@property (nonatomic,strong)YFTableCellF *f;

+(instancetype)cellWithTv:(UITableView *)tv dict:(YFTableCellF *)f idxed:(BOOL)idxed;
@property (nonatomic,assign)BOOL idxed;

@end
