//
//  YFWeb2VC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWeb2VC.h"

@implementation YFWeb2VC


-(void)loadView{
    [super loadView];
    self.view.backgroundColor=[UIColor blueColor];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:0];
}

@end
