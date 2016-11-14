//
//  YFBasNavVC.h
//  day39-project01
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFBasVC.h"

@interface YFBasNavVC : YFBasVC
@property (nonatomic,copy)NSString *navtitleStr;
@property (nonatomic,weak)UILabel *navtitle;
@property (nonatomic,weak)UIButton *lb;
@property (nonatomic,weak)UIButton *rb;

-(void)onLbClicked:(UIButton *)sender;
-(void)onRbClicked:(UIButton *)sender;
@end
