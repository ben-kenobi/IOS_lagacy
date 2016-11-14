//
//  YFHeaderFooterView.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic,assign)UITableViewCellEditingStyle style;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier tv:(UITableView *)tv andH:(CGFloat)h;
@end
