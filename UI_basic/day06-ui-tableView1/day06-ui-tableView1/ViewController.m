//
//  ViewController.m
//  day06-ui-tableView1
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFCarMod.h"
#import "YFHeroMod.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,weak) UITableView *tv;
@property (nonatomic,strong) NSMutableArray *dataAry;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(void)initUI{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    [tv setRowHeight:65];
    tv.dataSource=self;
    tv.delegate=self;
    self.tv=tv;
    [tv setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tv setSeparatorColor:[UIColor cyanColor]];
    [tv setSeparatorInset:(UIEdgeInsets){0,30,0,30}];
    [tv setAllowsMultipleSelection:NO];
    [tv setAllowsSelection:YES];
    
    
    
    UIView *fv=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 0, 50)];
    [fv setBackgroundColor:[UIColor redColor]];
    [tv setTableFooterView:fv];
    
    UIView *hv=[[UIView alloc] initWithFrame:CGRectMake(20,20, 0, 30)];
    [hv setBackgroundColor:[UIColor yellowColor]];
    [tv setTableHeaderView:hv];
    
    tv.editing=YES;
    
    
}
-(void)initState{
    
}
-(void)initListeners{
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [self.dataAry removeObjectAtIndex:indexPath.row];
        [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if(editingStyle==UITableViewCellEditingStyleInsert){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"add name" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        av.tag=indexPath.row;
        [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [av textFieldAtIndex:0].placeholder=@"name";
        [av textFieldAtIndex:1].placeholder=@"intro";
        UIImageView *iv=[[UIImageView alloc]initWithFrame:(CGRect){0,0,50,50}];
        iv.image=[UIImage imageNamed:@"1371103804008"];
        iv.tag=101;
        UITextField *tf=[[UITextField alloc] initWithFrame:CGRectMake(50,50, 150, 33)];
        [tf setBackground:[UIImage imageNamed:@"1371103804008"]];
        tf.text=@"12312312";
        tf.tag=102;
        
        
        [av addSubview:iv];
        [av addSubview:tf];
        tf.hidden=NO;
        iv.hidden=NO;
        NSLog(@"%@----\n-----\n%@---\n--\n%@",[av viewWithTag:101],[av viewWithTag:102],[av textFieldAtIndex:0]);
        [av show];
        
    }
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView.message isEqualToString:@"input newname"]){
        if(buttonIndex==1){
            NSString * txt=[alertView textFieldAtIndex:0].text;
            YFHeroMod *mod=_dataAry[alertView.tag];
            mod.name=txt;
            NSIndexPath *idxp=[NSIndexPath indexPathForRow:alertView.tag inSection:0];
            [self.tv reloadRowsAtIndexPaths:@[idxp] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }else if([alertView.message isEqualToString:@"add name"]){
        if(buttonIndex==1){
            NSString *txt=[alertView textFieldAtIndex:0].text;
            NSString *desc=[alertView textFieldAtIndex:1].text;
            YFHeroMod *mod=[[YFHeroMod alloc] init];
            mod.name=txt;
            mod.intro=desc;
            mod.icon=@"173890255948";
            [self.dataAry insertObject:mod atIndex:alertView.tag];
            NSIndexPath *idxp=[NSIndexPath indexPathForRow:alertView.tag inSection:0];
            [self.tv insertRowsAtIndexPaths:@[idxp] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:nil message:@"input newname" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
    alertV.alertViewStyle=UIAlertViewStylePlainTextInput;
    alertV.tag=indexPath.row;
    [alertV textFieldAtIndex:0].text=[self.dataAry[indexPath.row] valueForKey:@"name"];
    [alertV show];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    YFHeroMod *mod=self.dataAry[indexPath.row];
    
    static NSString *iden=@"herocel";
    
    UITableViewCell *cel=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cel){
        cel=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        [cel setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cel.textLabel.text=mod.name;
    cel.textLabel.font=[UIFont systemFontOfSize:15];
    cel.detailTextLabel.text=mod.intro;
    cel.imageView.image=[UIImage imageNamed:mod.icon];
    [cel setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
 
    return cel;
}



-(NSMutableArray *)dataAry{
    if(nil==_dataAry){
        _dataAry=[NSMutableArray array];
        NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"heros" ofType:@"plist"]];
        for(NSDictionary *dict in ary){
            [_dataAry addObject:[YFHeroMod modWithDict:dict]];
        }
    }
    return _dataAry;
}

@end
