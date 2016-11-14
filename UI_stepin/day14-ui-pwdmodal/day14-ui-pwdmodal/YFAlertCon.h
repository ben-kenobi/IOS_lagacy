//
//  YFAlertCon.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAlertCon : UIViewController

-(instancetype)initWithTitle:(NSString *)title mes:(NSString *)mes;

-(void)addBtn:(NSString *)title action:(void (^)(YFAlertCon *aler))action;
-(void)addTfWithConf:(void(^)(UITextField *tf))conf;

@property (nonatomic,strong)NSMutableArray *tfs;
@end
