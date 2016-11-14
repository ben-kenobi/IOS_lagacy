//
//  CoverView.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "CoverView.h"
@interface CoverView()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *roller;

@end
@implementation CoverView

-(void)setFrame:(CGRect)frame andLabFrame:(CGRect)fra{
    self.frame=frame;
    self.lab.frame=fra;
    _roller.center=(CGPoint){self.center.x,self.center.y-50};
}
@end
