


//
//  OCVC.m
//  day42-swiftbeginning
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "OCVC.h"

@interface OCVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tv;
@end

@implementation OCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tv=[[UITableView alloc] initWithFrame:self.view.bounds style:0];
    [self.view addSubview:self.tv];
    self.tv.delegate=self;
    self.tv.dataSource=self;
    self.tv.rowHeight=70;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@""];
}

@end
