//
//  ListController.m
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ListController.h"
#import "YFContact.h"
#import "AddController.h"
#import "UpdateController.h"


@interface ListController ()<AddProtocol,UpdateDelegate>
@property (nonatomic,weak)UIBarButtonItem *bi;
@property (nonatomic,weak)UIBarButtonItem *add;
@property (nonatomic,weak)UIBarButtonItem *trash;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)dealloc{
    [self saveDatas];
//    NSLog(@"%@",[self dataStorePath]);
}

-(void)saveDatas{
    [[NSKeyedArchiver archivedDataWithRootObject:self.datas] writeToFile:[self dataStorePath] atomically:YES];
}

-(void)updateList{
    [self.tableView reloadData];
}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *bi=[[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
    self.bi=bi;
    [self.navigationItem setLeftBarButtonItem:bi];
    
    UIBarButtonItem *add=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onBtnClicked:)];
    self.add=add;
    UIBarButtonItem *trash=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(onBtnClicked:)];
    self.trash=trash;
    [trash setTintColor:[UIColor orangeColor]];
    
    [self.navigationItem setRightBarButtonItems:@[add,trash]];
    [self.tableView setTableFooterView:[[UIView alloc] init] ];
}


-(void)addContact:(YFContact *)contact{
    [self.datas addObject:contact];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_datas.count-1 inSection:0]] withRowAnimation:0];
}
-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[self dataStorePath]]];
    }
    return _datas;
}

-(NSString *)dataStorePath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cons.plist"];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFContact *contact=_datas[indexPath.row];
    UpdateController *uc=[[UpdateController alloc] init];
    [uc setCont:contact];
    [uc setDelegate:self];
    [self.navigationController showViewController:uc sender:nil];
}
-(void)onBtnClicked:(id)item{
    if(item==self.bi){
        UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"alert" message:@"logout?" preferredStyle:UIAlertControllerStyleActionSheet];
        [ac addAction:[UIAlertAction actionWithTitle:@"NO" style:0 handler:^(UIAlertAction *action) {
            nil;
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:@"YES" style:0 handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"autologin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }]];
        [self presentViewController:ac animated:YES completion:nil];
    }else if(item==self.add){
        AddController *ac=[[AddController alloc] init];
        [ac setDelegate:self];
        [self.navigationController showViewController:ac sender:nil];
    }else if(item ==  self.trash){
        self.tableView.editing=!self.tableView.editing;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==1){
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"DEL";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"listitemiden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
    }
    YFContact *contact=_datas[indexPath.row];
    cell.textLabel.text=contact.name;
    cell.detailTextLabel.text=contact.num;
    return cell;
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
