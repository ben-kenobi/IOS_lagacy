//
//  YFMylotVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMylotVC.h"
#import "YFCollectionVC.h"
#import "YFSettingCell.h"
#import "YFHelpVC.h"
@interface YFMylotVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@property (nonatomic,weak)UITextField *tf;
@property (nonatomic,weak)UIDatePicker *dp;
@property (nonatomic,weak)UIBarButtonItem *back;
@end

@implementation YFMylotVC

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas[section][@"mems"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _datas[section][@"header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return _datas[section][@"footer"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dict=[self dictBy:indexPath];
    return [YFSettingCell cellWithTv:tableView dict:dict];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[self dictBy:indexPath];
    if(dict[@"vc"]){
        Class clz=NSClassFromString(dict[@"vc"]);
        UIViewController * obj=[[clz alloc] init];
        SEL sel=NSSelectorFromString(@"setPname:");
        if(obj){
            if([obj respondsToSelector:sel])
                [obj performSelector:sel withObject:dict[@"pname"]];
            obj.title=dict[@"title"];
            [self.navigationController showViewController:obj sender:nil];
        }
    }else if(dict[@"sel"]){
        SEL selec=NSSelectorFromString(dict[@"sel"]);
        if([self respondsToSelector:selec])
            [self performSelector:selec withObject:indexPath];
    }
}
-(void)checkVersion:(NSIndexPath *)idx{
    UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"alert" message:@"no new version" preferredStyle:1];
    [aler addAction:[UIAlertAction actionWithTitle:@"OK" style:1 handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:aler animated:YES completion:nil];
}

-(void)onCellClicked:(NSIndexPath *)idx{
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:idx];
    UITextField *tf=[[UITextField alloc] init];
    UIDatePicker *dp=[[UIDatePicker alloc] init];
    UIToolbar *tb=[[UIToolbar alloc] initWithFrame:(CGRect){0,0,0,44}];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithTitle:@"hide" style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    item1.tag=1;
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    UIBarButtonItem *item3=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:0 action:0 ];
    item2.tag=2;
    tb.items=@[item1,item3,item2];
    dp.datePickerMode=UIDatePickerModeTime;
    [dp setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_cn"]];
    tf.inputView=dp;
    tf.inputAccessoryView=tb;
    [tf becomeFirstResponder];
    [cell addSubview:tf];
    self.tf=tf;
    self.dp=dp;
}


-(void)onItemClicked:(id)sender{
    NSInteger tag=[sender tag];
    if(1==tag){
        [self.tf removeFromSuperview];
        self.tf=nil;
    }else if (2==tag){
        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        NSDateFormatter *form=[[NSDateFormatter alloc] init];
        form.dateFormat=@"HH:mm";
        NSString *str=[form stringFromDate:self.dp.date];
        cell.detailTextLabel.text=str;
        [self.tf removeFromSuperview];
        self.tf=nil;
    }else if(sender==self.back){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:self.pname ofType:@"plist"]]];
    }
    return _datas;
}

-(void)initUI{
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector( onItemClicked:)];
    self.navigationItem.leftBarButtonItem=back;
    self.back=back;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(NSDictionary *)dictBy:(NSIndexPath *)path{
    return _datas[path.section][@"mems"][path.row];
}

@end
