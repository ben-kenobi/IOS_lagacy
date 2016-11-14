//
//  YFNavCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNavCon.h"

@interface YFNavCon ()

@end

@implementation YFNavCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:0];
    self.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)showViewController:(UIViewController *)vc sender:(id)sender{
    vc.hidesBottomBarWhenPushed=YES;
    [super showViewController:vc sender:sender];
}

-(void)setTitle:(NSString *)title{
//    [super setTitle:title];
    if(self.viewControllers.count){
        [self.viewControllers[0] navigationItem].title=title;
        
    }

}
@end







