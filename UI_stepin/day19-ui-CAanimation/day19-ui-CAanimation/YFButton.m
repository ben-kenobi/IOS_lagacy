//
//  YFButton.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFButton.h"
#import "UIView+Ex.h"

@implementation YFButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x=self.titleLabel.w;
    self.titleLabel.x=0;
}

@end
