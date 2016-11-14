//
//  YFListAdap.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFListAdap.h"
#import "YFHFv.h"
#import "YFCate.h"
#import "YFAlertCon.h"

@interface YFListAdap ()
@property (nonatomic ,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;

@end


@implementation YFListAdap


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YFCate *cate=_datas[section];
    
    return cate.show?cate.apps.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"listcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    }
    NSDictionary *dict=[_datas[indexPath.section] apps][indexPath.row];
    cell.textLabel.text=dict[@"desc"];
    cell.detailTextLabel.text=dict[@"class"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YFHFv *hfv= [YFHFv vWithTv:tableView cate:_datas[section] section:section];
    if(![hfv delBlock]){
        [hfv setDelBlock:^BOOL(NSInteger section) {
            if(![self.delegate respondsToSelector:@selector(presentCon:)])
                return 0;
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"alert" message:@"sure delete whole section?\n this operation can not be undo" preferredStyle:1];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:1 handler:^(UIAlertAction *action) {
                [self delSection:section];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:0 handler:0]];
            alert.view.tag=section;
            [self.delegate presentCon:alert];
            
            return 0;
        }];
        
        [hfv setAddBlock:^BOOL(NSInteger section) {
            if(![self.delegate respondsToSelector:@selector(presentCon:)])
                return 0;
            YFAlertCon *aler=[[YFAlertCon alloc] initWithTitle:@"addRow" mes:@"insertRow"];
            [aler addTfWithConf:^(UITextField *tf) {
                [tf setPlaceholder:@"classname"];
            }];
            [aler addTfWithConf:^(UITextField *tf) {
                [tf setPlaceholder:@"describe"];
            }];
            [aler addBtn:@"cancel" action:^(YFAlertCon *aler) {
                
            }];
            [aler addBtn:@"OK" action:^(YFAlertCon *aler) {
                NSString *class=[aler.tfs[0] text];
                NSString *desc=[aler.tfs[1] text];
                if(class.length){
                    [self appendRows:@[@{@"class":class,@"desc":desc}] atSection:section];
                }
            }];
            
            [self.delegate presentCon:aler];
            return 0;
        }];
    }
    return hfv;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==1){
        [self delRow:indexPath];
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(toCon:)]){
        NSString *classname= [_datas[indexPath.section] apps][indexPath.row] [@"class"];
        Class c=NSClassFromString(classname);
        UIViewController *con=[[c alloc] init];
        con.navigationItem.title=classname;
        [self.delegate toCon:con];
    }
}

+(instancetype)adapWithTv:(UITableView *)tv{
    YFListAdap *adap=[[self alloc] initWithTv:tv];
    return adap;
}

-(instancetype)initWithTv:(UITableView *)tv{
    if(self=[super init]){
        self.tv=tv;
        tv.delegate=self;
        tv.dataSource=self;
        _datas=[NSMutableArray array];
        [self loadDatas];
    }
    return self;
}

-(void)appendDatas:(NSArray *)datas{
     NSInteger from=_datas.count;
    [self.datas addObjectsFromArray:datas];
    NSIndexSet *is=[NSIndexSet indexSetWithIndexesInRange:(NSRange){from,datas.count}];
    [self.tv insertSections:is withRowAnimation:0];
    [self saveDatas];
}

-(void)appendRows:(NSArray *)rows atSection:(NSInteger)section{
    YFCate *cate=_datas[section];
    NSInteger from=cate.apps.count;
    [cate.apps addObjectsFromArray:rows];
    NSInteger to=cate.apps.count;
    NSMutableArray *mary=[NSMutableArray array];
    for(NSInteger i=from;i<to;i++){
        [mary addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    cate.show=YES;
    [self.tv insertRowsAtIndexPaths:mary withRowAnimation:0];
     [self saveDatas];
}

-(void)delRow:(NSIndexPath *)idx{
    YFCate *cate=_datas[idx.section];
    [cate.apps removeObjectAtIndex:idx.row];
    [self.tv deleteRowsAtIndexPaths:@[idx] withRowAnimation:0];
     [self saveDatas];
}
-(void)delSection:(NSInteger)section{
    [_datas removeObjectAtIndex:section];
//    [self.tv deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:0];
    [self.tv reloadData];
     [self saveDatas];
}



-(void)loadDatas{
    [self.datas addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:PATH4DATAS]];
}
-(void)saveDatas{
    [NSKeyedArchiver archiveRootObject:self.datas toFile:PATH4DATAS];
}

@end
