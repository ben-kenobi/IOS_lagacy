//
//  UIView+EXtension.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIView+EXtension.h"
#import "Masonry.h"

@implementation UIView (EXtension)

+(instancetype)viewWithView:(UIView *)view andFlagDict:(NSDictionary *)dict frame:(CGRect)frame{
    if(!view){
        view=[[self alloc] initWithFrame:frame];
        UILabel *lab=[[UILabel alloc] init];
        [view addSubview:lab];
       

        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@(frame.size.width*.3));
        }];
        
        UIImageView *iv=[[UIImageView alloc] init];
         [view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.width.equalTo(@(frame.size.width*.3));
            make.height.equalTo(@(frame.size.height));
            make.top.equalTo(@0);
        }];
        
    }
    UILabel *lab =view.subviews[0];
    UIImageView *iv=view.subviews[1];
    lab.text=dict[@"name"];
    iv.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:dict[@"icon"] ofType:nil]];
    return view;
}
@end
