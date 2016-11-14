//
//  YFListAdap.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#define PATH4DATAS [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"list.plist"]

@protocol YFListAdapDelegate <NSObject>
-(void)toCon:(id)con;
-(void)presentCon:(id)con;
@end

@interface YFListAdap : NSObject<UITableViewDataSource,UITableViewDelegate>

+(instancetype)adapWithTv:(UITableView *)tv;
@property (nonatomic,weak)id<YFListAdapDelegate>delegate;
-(void)appendDatas:(NSArray *)datas;

-(void)appendRows:(NSArray *)rows atSection:(NSInteger)section;
-(void)delRow:(NSIndexPath *)idx;
-(void)delSection:(NSInteger)section;

@end
