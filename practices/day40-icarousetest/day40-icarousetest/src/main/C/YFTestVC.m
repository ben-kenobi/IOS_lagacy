//
//  YFTestVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFTestVC.h"

CGFloat angleBy(CGPoint p1,CGPoint p2,CGPoint p3){
   CGFloat a1=  atan((p1.y-p2.y)/(p1.x-p2.x));
    CGFloat a2=atan((p3.y-p2.y)/(p3.x-p2.x));
    return a2-a1;
}
CGFloat lenthBPs(CGPoint p1,CGPoint p2){
    CGFloat dy=(p2.y-p1.y);
    CGFloat dx=(p2.x-p1.x);
    return sqrt(dy*dy+dx*dx);
}

@interface YFTestVC ()

@end

@implementation YFTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%.2f",angleBy((CGPoint){4,0}, (CGPoint){0,0}, (CGPoint){0,4}));


}

@end
