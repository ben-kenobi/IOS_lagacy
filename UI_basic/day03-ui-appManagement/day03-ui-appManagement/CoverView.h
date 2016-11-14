//
//  CoverView.h
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoverView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lab;

-(void)setFrame:(CGRect)frame andLabFrame:(CGRect)fra;
    

@end
