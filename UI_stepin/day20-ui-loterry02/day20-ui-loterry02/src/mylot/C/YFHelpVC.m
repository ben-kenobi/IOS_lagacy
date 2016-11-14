//
//  YFHelpVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHelpVC.h"
#import "YFWebVC.h"
#import "YFNavCon.h"

@interface YFHelpVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFHelpVC



-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"helpcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    cell.textLabel.text=_datas[indexPath.row][@"title"];
    cell.detailTextLabel.text=_datas[indexPath.row][@"html"];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFWebVC *web=[[YFWebVC alloc] init] ;
    UINavigationController *nav= [[YFNavCon alloc] initWithRootViewController:web];
    nav.title=_datas[indexPath.row][@"title"];
    web.path=_datas[indexPath.row][@"html"];
    web.anchor=_datas[indexPath.row][@"id"];
    [web setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:nav animated:YES completion:0] ;
    
}




-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
       [_datas addObjectsFromArray: [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"help.json" ofType:0]] options:0 error:0]];
    }
    return _datas;
}

@end
