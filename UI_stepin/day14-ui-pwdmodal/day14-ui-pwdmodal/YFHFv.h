//
//  YFHFv.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFCate;

@interface YFHFv : UITableViewHeaderFooterView

@property (nonatomic,strong)BOOL (^delBlock)(NSInteger section);
@property (nonatomic,strong)BOOL (^addBlock)(NSInteger section);

@property (nonatomic,strong)YFCate *cate;
+(instancetype)vWithTv:(UITableView *)tv cate:(YFCate *)cate section:(NSInteger)section;


@end
