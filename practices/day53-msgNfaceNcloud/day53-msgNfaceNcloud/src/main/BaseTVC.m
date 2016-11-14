

//
//  BaseTVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "BaseTVC.h"
#import "AVQuery.h"
#import "MsgVC.h"

@interface BaseTVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation BaseTVC


-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(edit)];
    
    
}

-(void)edit{
    [self.navigationController showViewController:[[MsgVC alloc]init] sender:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AVQuery *query = [AVQuery queryWithClassName:@"MsgTable"];
    [query orderByDescending:@"createTime"];
    [query whereKey:@"type" equalTo:@(self.type)];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) return ;
        [self.datas removeAllObjects];
        [self.datas addObjectsFromArray:objects];
 
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];

        });
    }];
}



#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"celliden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    AVObject *object = self.datas[indexPath.row];
    
    cell.textLabel.text = [object objectForKey:@"content"];
    cell.detailTextLabel.text = [[object objectForKey:@"title"]  stringByAppendingFormat:@"---%@-----%@",[object objectForKey:@"createTime"],object.createdAt];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


iLazy4Ary(datas, _datas)
@end
