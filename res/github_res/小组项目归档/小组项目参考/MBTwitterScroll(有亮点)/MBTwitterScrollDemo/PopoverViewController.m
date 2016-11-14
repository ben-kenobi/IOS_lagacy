//
//  PopoverViewController.m
//  TwitterScroll
//
//  Created by Martin Blampied on 07/02/2015.
//  Copyright (c) 2015 MartinBlampied. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.meButton.layer.cornerRadius = 10;
    self.meButton.layer.borderWidth = 3;
    self.meButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.meButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)meClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=martinblampied"]];
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com