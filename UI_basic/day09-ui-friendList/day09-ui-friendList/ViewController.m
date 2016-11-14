//
//  ViewController.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFTVAdap.h"
#import "YFAppAdap.h"

@interface ViewController ()

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)YFTVAdap *adap;
@property (nonatomic,strong)YFAppAdap *adap2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    
    self.adap=[YFTVAdap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil]] tv:self.tv];
//    self.adap2=[YFAppAdap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps_full.plist" ofType:nil]] tv:self.tv];
//    [self.tv setAllowsSelection:NO];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
