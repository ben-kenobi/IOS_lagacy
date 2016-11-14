//
//  ListController.m
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ListController.h"
#import "AddController.h"
#import "YFContact.h"
#import "EditController.h"

@interface ListController ()<AddDelegate,EditDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *add;
@property (weak,nonatomic) UIBarButtonItem *trash;
@property (strong,nonatomic)NSMutableArray *datas;
@property (strong,nonatomic)NSIndexPath *idx;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"listcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    YFContact *con=_datas[indexPath.row];
    cell.textLabel.text=con.name;
    cell.detailTextLabel.text=con.num;
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"DEL";
}

-(void)commitEdit{
    [self.tableView reloadRowsAtIndexPaths:@[self.idx] withRowAnimation:0];
}
-(void)addContact:(YFContact *)cont{
    [self.datas addObject:cont];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_datas.count-1 inSection:0]] withRowAnimation:0];
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
//        NSString *path=[self datasPath];
//        NSArray *ary=[NSArray arrayWithContentsOfFile:path];
//        for(NSDictionary *dict in ary){
//            [_datas addObject:[YFContact conWithDict:dict]];
//        }
        [_datas addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[self datasPath]]]];
        NSData  *dta=[NSData dataWithContentsOfFile:[self datasPath]];
                      
        NSLog(@"%@---%@",[dta classForCoder],[dta classForKeyedArchiver]);
    }
    return _datas;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id obj=segue.destinationViewController;
    if([obj isKindOfClass:[AddController class]]){
        AddController *ac=obj;
        ac.title=@"Add";
        ac.delegate=self;
    }else if([obj isKindOfClass:[EditController class]]){
        EditController *ec=obj;
        ec.title=@"Edit";
        ec.delegate=self;
        self.idx=[self.tableView indexPathForSelectedRow];
        YFContact *con=_datas[_idx.row];
        [ec setCon:con];
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    }
}
-(void)initUI{
    [self.tableView setTableFooterView:[[UIView alloc] init] ];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(onBtnClicked:)];
    self.trash=item;
    [item setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItems=@[self.navigationItem.rightBarButtonItem,item];
}

-(void)initState{
    
}
-(void)initListeners{
    [self.logout setTarget:self];
    [self.logout setAction:@selector(onBtnClicked:)];
    
}

-(void)onBtnClicked:(id)sender{
    if(sender==_logout){
        UIAlertController *uc=[UIAlertController alertControllerWithTitle:@"note" message:@"logout?" preferredStyle:UIAlertControllerStyleActionSheet];
        [uc addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            
        }]];
        [uc addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self saveContactsUseArchiver];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"autologin"];
            NSUserDefaults *ud1=[NSUserDefaults standardUserDefaults];
            [ud1 synchronize];
        }]];
        
        [self presentViewController:uc animated:YES completion:^{
            
        }];
    }else if(sender==self.trash){
        self.tableView.editing=!self.tableView.editing;
    }
}

-(NSString *)datasPath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cons.plist"];
}
-(NSUserDefaults *)udWithName:(NSString *)name{
    return [[NSUserDefaults alloc] initWithSuiteName:name];
}

-(void)saveContactsUseArchiver{
    NSString *path=[self datasPath];
    NSData *dta=[NSKeyedArchiver archivedDataWithRootObject:self.datas];
    
    BOOL b=[dta writeToFile:path atomically:YES];
    
    
    NSLog(@"--%d---\n-%@",b,path);
}

-(void)saveContacts{
 
   
    NSMutableArray *mary=[NSMutableArray array];
    for(YFContact *con in self.datas){
        [mary addObject:@{@"name":con.name,@"num":con.num}];
    }
    NSString *path=[self datasPath];
    BOOL b=[mary writeToFile:path atomically:YES];
    
    
    NSLog(@"--%d---\n-%@",b,path);
    
}
@end
