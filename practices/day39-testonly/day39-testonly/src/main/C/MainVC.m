//
//  MainVC.m
//  day39-testonly
//
//  Created by apple on 15/11/19.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tv;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor randomColor]];
    self.tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tv];
    self.tv.dataSource=self;
        [self.tv setEstimatedRowHeight:44];
    [self.tv setRowHeight:UITableViewAutomaticDimension];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@""];
    UILabel *title=[[UILabel alloc] init];
    UILabel *subti=[[UILabel alloc] init];
    [title setFont:[UIFont systemFontOfSize:20]];
    [subti setFont:[UIFont systemFontOfSize:20]];
    [title setNumberOfLines:0];
    [subti setNumberOfLines:0];
    
    [cell.contentView addSubview:title];
    [cell.contentView addSubview:subti];
    title.text=@"qlkwjeklqjweklqjwekljqwlkejqlwkejklqwjelkqwje";
    subti.text=@"qlkdjlkqjdwklqjdlkqwjdlqwjdklwjqdklwjqkdlwjqkldjlkqwjdqw";
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-25);
        make.top.equalTo(@10);
    }];
    [subti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-25);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
    }];
    
    return cell;
}
@end
