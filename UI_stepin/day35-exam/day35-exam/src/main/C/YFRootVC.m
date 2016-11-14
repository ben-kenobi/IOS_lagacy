//
//  YFRootVC.m
//  day35-exam
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFRootVC.h"
#import "MBProgressHUD+MJ.h"
#import "YFDetailVC.h"
#import "YFDetailVC02.h"

@interface YFRootVC ()

@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation YFRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"英雄展示";
    [self.tableView setTableFooterView:[[UIView alloc] init] ];
    [self loadMore];
}

-(void)loadMore{
    [iApp setNetworkActivityIndicatorVisible:YES];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *ary=[NSArray arrayWithContentsOfURL:iURL(@"http://localhost/hero/heros.plist")];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self appendDatas:ary];
            [iApp setNetworkActivityIndicatorVisible:NO];
        }) ;
    }) ;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFDetailVC *vc=[[YFDetailVC alloc] init];
    vc.hid=self.datas[indexPath.row][@"heroId"];
    [self.navigationController showViewController:vc sender:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const iden=@"celliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

    cell.textLabel.text=self.datas[indexPath.row][@"name"];
    return cell;
}

-(void)appendDatas:(NSArray *)ary{
    [self.datas addObjectsFromArray:ary];
    [self.tableView reloadData];
}
iLazy4Ary(datas, _datas)

@end
