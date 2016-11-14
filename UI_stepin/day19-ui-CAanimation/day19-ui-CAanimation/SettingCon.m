//
//  SettingCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "SettingCon.h"

@interface SettingCon ()

@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation SettingCon



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section][@"mems"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"settingcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
    }
    NSDictionary *dict=self.datas[indexPath.section][@"mems"][indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:dict[@"img"]];
    cell.textLabel.text=dict[@"title"];
    
    Class clz=NSClassFromString(dict[@"acclz"]);
    UIView *obj;
    if(clz)
        obj=[[clz alloc] init];
    if([obj isKindOfClass:[UIImageView class]]){
        (( UIImageView*)obj).image=[UIImage imageNamed:dict[@"acimg"]];
        [obj sizeToFit];
    }
    if(obj)
        cell.accessoryView=obj;
    else
        cell.accessoryView=nil;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.section][@"mems"][indexPath.row];
    Class clz= NSClassFromString(dict[@"vc"]);
    id obj=[[clz alloc]init];
    if(clz==NSClassFromString(@"SettingCon")){
        [obj setPlistname:dict[@"pname"]];
        [self.navigationController showViewController:obj sender:nil];
    }else if(obj){
        [self.navigationController showViewController:obj sender:nil];
    }
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:self.plistname ofType:@"plist"]]];
    }
    return _datas;
}

-(instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.tableView setSeparatorInset:(UIEdgeInsets){0,5,0,5}];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){0,0,[UIImage imageNamed:@"arrow_right"].size}];
    btn.imageView.transform=CGAffineTransformMakeRotation(M_PI);
    [btn.imageView setContentMode:UIViewContentModeCenter];
    [btn.imageView.layer setMasksToBounds:NO];
    [btn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn ];

    self.navigationItem.leftBarButtonItem=item;

}

-(void)onBtnClicked:(id)sender{
    
}


@end
