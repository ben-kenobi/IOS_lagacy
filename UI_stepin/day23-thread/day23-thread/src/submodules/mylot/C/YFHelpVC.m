//
//  YFHelpVC.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHelpVC.h"
#import "YFWebVC.h"

@interface YFHelpVC ()


@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFHelpVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"helpcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:iden];
    }
    cell.textLabel.text=self.datas[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YFWebVC *webvc=[[YFWebVC alloc] init];
    [webvc setDict:self.datas[indexPath.row]];

    [self.navigationController showViewController:webvc sender:nil];
    
}

-(void)initUI{
    
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:iRes(@"help.json")] options:0 error:0]];
    }
    return _datas;
}


-(instancetype)init{
    return [super initWithStyle:UITableViewStylePlain];
}

@end
