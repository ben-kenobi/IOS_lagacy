//
//  ListController.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ListController.h"
#import "YFListAdap.h"
#import "YFAlertCon.h"
#import "YFCate.h"

@interface ListController ()<YFListAdapDelegate>

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)YFListAdap *adap;
@property (nonatomic,weak)UIBarButtonItem *trash;
@property (nonatomic,weak)UIBarButtonItem *add;


@end

@implementation ListController





-(void)presentCon:(id)con{
    if(con)
        [self presentViewController:con animated:YES completion:0];
}
-(void)toCon:(id)con{
    if(con)
        [[self navigationController] showViewController:con sender:nil];
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.trash){
        self.tv.editing=!self.tv.editing;
    }else if(sender==self.add){
        YFAlertCon *aler=[[YFAlertCon alloc] initWithTitle:@"title" mes:@"message"];

        [aler addTfWithConf:^(UITextField *tf) {
            tf.placeholder=@"sectionname";
        }];
        [aler addBtn:@"cancel" action:^(YFAlertCon *aler){}];
        [aler addBtn:@"OK" action:^(YFAlertCon *aler){
            NSString *str=[aler.tfs[0] text];
            if(str.length){
                YFCate *cate=[YFCate cateWithDict:@{@"name":str}];
                [self.adap appendDatas:@[cate]];
            }
        }];
        [self presentViewController:aler animated:YES completion:0];
    }
}



-(void)initUI{
    self.navigationItem.title=@"ROOT";
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tv setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:tv];
    self.tv=tv;
    [tv setRowHeight:50];
    
    self.adap=[YFListAdap adapWithTv:tv];
    self.adap.delegate=self;

    UIBarButtonItem *trash=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(onBtnClicked:)];
    UIBarButtonItem *add=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onBtnClicked:)];
    self.trash=trash;
    self.add=add;
    self.navigationItem.rightBarButtonItems=@[add,trash];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
