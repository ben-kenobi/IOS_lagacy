//
//  ViewController.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFTvAdap.h"

@interface ViewController ()

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong) YFTvAdap *adap;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tv setAllowsSelection:YES];
    self.tv=tv;
    [self.view addSubview:tv];
    [tv setSectionHeaderHeight:50];
    [self.tv setSeparatorInset:(UIEdgeInsets){0,10,0,10}];
    
    self.adap=[YFTvAdap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"friends" ofType:@"plist"]] tv:tv];
    
}




@end
