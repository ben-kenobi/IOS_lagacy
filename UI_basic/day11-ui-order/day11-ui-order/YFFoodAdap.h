//
//  YFFoodAdap.h
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface YFFoodAdap : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>

+(instancetype)adapWithPv:(UIPickerView *)pv datas:(NSArray *)datas labs:(NSArray *)labs;


-(void)randomSelect;
@end
