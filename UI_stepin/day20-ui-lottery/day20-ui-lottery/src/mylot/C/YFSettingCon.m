//
//  YFSettingCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSettingCon.h"
#import "YFSettingCell.h"

@interface YFSettingCon ()
@property (nonatomic,weak) UIBarButtonItem *back;


@end

@implementation YFSettingCon


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.datas[section][@"header"];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
     return self.datas[section][@"footer"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section][@"mems"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict=_datas[indexPath.section][@"mems"][indexPath.row];
    
    return [YFSettingCell cellWithDict:dict andTv:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.section][@"mems"][indexPath.row];
    Class vc=NSClassFromString(dict[@"vc"]);
    id obj=[[vc alloc] init];
    if([obj isKindOfClass:NSClassFromString(@"YFSettingCon")]){
        [obj setPname:dict[@"pname"]];
    }
    if(obj){
        [obj setTitle:dict[@"title"]];
        [self.navigationController showViewController:obj sender:0];
    }
}


-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        if(self.pname)
            [_datas addObjectsFromArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:self.pname ofType:@"plist"]]];
    }
    return _datas;
}


-(void)onBtnClicked:(id)sender{
   
    if(sender==self.back){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)initUI{
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
    self.back=back;
    self.navigationItem.leftBarButtonItem=back;
    
    [self.tableView setSeparatorInset:(UIEdgeInsets){0,5,0,5}];
}

-(instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

@end
