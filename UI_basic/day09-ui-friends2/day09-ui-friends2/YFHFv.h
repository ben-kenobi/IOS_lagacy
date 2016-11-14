//
//  YFHFv.h
//  day09-ui-friends2
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFHFv,YFFris;

@protocol YFHFvDelegate <NSObject>
-(void)onBtnClicked:(YFHFv *)hfv;

@end
 
@interface YFHFv : UITableViewHeaderFooterView

@property (nonatomic,strong)YFFris *fris;
@property (nonatomic,weak)id<YFHFvDelegate>delegate;

+(instancetype)viewWithTableView:(UITableView *)tv andFris:(YFFris *)fris delegate:(id<YFHFvDelegate>)delegate;
@end
