//
//  YFDiscVC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDiscVC.h"

#import "YFDiscCell.h"

@interface YFDiscVC ()
@property (nonatomic,strong)NSMutableArray *datas;


@end

@implementation YFDiscVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[self dictBy:indexPath];
    id obj=[[NSClassFromString(dict[@"vc"]) alloc] init];
    if(obj)
       [self.navigationController showViewController:obj sender:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section][@"mems"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFDiscCell cellWithTv:tableView dict:[self dictBy:indexPath]];
}


-(void)initUI{
    [self.tableView setRowHeight:100];
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[[NSMutableArray alloc] init];
        [_datas addObjectsFromArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:_pname ofType:@"plist"]]];
    }
    return _datas;
}
-(NSDictionary *)dictBy:(NSIndexPath *)path{
    return self.datas[path.section][@"mems"][path.row];
}
-(instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

@end
