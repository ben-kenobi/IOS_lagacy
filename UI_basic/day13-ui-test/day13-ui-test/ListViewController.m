//
//  ListViewController.m
//  day13-ui-test
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ListViewController.h"
#import "AddViewController.h"


@interface ListViewController ()<AddCDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *quit;
@property (strong,nonatomic)NSMutableArray *datas;
@property (strong,nonatomic)UIBarButtonItem *trash;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initListeners];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"infocell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden
                           ];
    cell.textLabel.text=self.datas[indexPath.row][@"name"];
    cell.detailTextLabel.text=self.datas[indexPath.row][@"num"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)addOrUpdateInfo:(NSDictionary *)info idx:(NSIndexPath *)idx{
    if(idx){
        [self.datas replaceObjectAtIndex:idx.row withObject:info];
        [self.tableView reloadRowsAtIndexPaths:@[idx] withRowAnimation:0];
    }else{
        [self.datas addObject:info];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_datas.count-1 inSection:0]] withRowAnimation:0];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[sender class] isSubclassOfClass:[NSIndexPath class]]){
        NSIndexPath *curp=sender;
        [segue.destinationViewController setTitle:[NSString stringWithFormat:@"%@_update",self.title]] ;
        [segue.destinationViewController setInfo:_datas[curp.row]];
        [segue.destinationViewController setIdx:curp];
    }else{
        [segue.destinationViewController setTitle:[NSString stringWithFormat:@"%@_add",self.title]] ;
    }
    [segue.destinationViewController setDelegate:self];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"editsegue" sender:indexPath];
    
}

-(void)onBtnClicked:(id)sender{
 
    if(sender==self.quit){
        UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"alert" message:@"logout?" preferredStyle:UIAlertControllerStyleActionSheet];
        [ac addAction:[UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil]];
        [ac addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"autologin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }]];
        [self presentViewController:ac animated:YES completion:nil];
    }else if(sender==self.trash){
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

-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
       
        [_datas addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cons.plist"] ]];
    }
    return _datas;
}

-(void)saveDatas{
    [NSKeyedArchiver archiveRootObject:self.datas toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cons.plist"]];
   
}

-(void)dealloc{
    [self saveDatas];
}
-(void)initListeners{

    [self.quit setAction:@selector(onBtnClicked:)];
    [self.quit setTarget:self];
}
-(void)initUI{
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    UIBarButtonItem *trash=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(onBtnClicked:)];
    self.navigationItem.rightBarButtonItems=@[self.navigationItem.rightBarButtonItem,trash];
    self.trash=trash;
}


@end
