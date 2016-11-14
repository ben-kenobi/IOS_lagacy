//
//  YFHeroTvAdapter.m
//  day06-ui-tableView3
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHeroTvAdapter.h"
#import "YFHeroMod.h"

@interface YFHeroTvAdapter()
{
   __weak UIButton *btns[2];
}
@property (nonatomic,assign)UITableViewCellEditingStyle edisty;
@property (nonatomic,weak) UIView *header;

@end

@implementation YFHeroTvAdapter

+(instancetype)adapterWithTv:(UITableView *)tv adnData:(NSArray *)datas{
    YFHeroTvAdapter *obj=[[self alloc] init];
    obj.tv=tv;
    obj.datas=[NSMutableArray array];
    for(NSDictionary *dict in datas){
        [obj.datas addObject:[YFHeroMod modWithDict:dict]];
    }
    [obj initState];
    return obj;
}


-(void)initState{
    _edisty=0;
    [self.tv setEditing:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"new name" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
    [av setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [av textFieldAtIndex:0].text=[self.datas[indexPath.row] valueForKey:@"name"];
    av.tag=indexPath.row;
    [av show];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"heroCellIden";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    YFHeroMod *mod=self.datas[indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:mod.icon];
    cell.textLabel.text=mod.name;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.text=mod.intro;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        NSInteger row=indexPath.row;
        [self.datas removeObjectAtIndex:row];
        [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if(editingStyle==UITableViewCellEditingStyleInsert){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"add name and intro" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [[av textFieldAtIndex:0] setPlaceholder:@"name"];
        [[av textFieldAtIndex:1] setPlaceholder:@"intro"];
        av.tag=indexPath.row;
        [av show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *mes=[alertView message];
    if([@"add name and intro" isEqualToString:mes]&&buttonIndex==1){
        NSInteger row=alertView.tag;
        YFHeroMod *mod=[self.datas[row] copy];
        mod.name=[alertView textFieldAtIndex:0].text;
        mod.intro=[alertView textFieldAtIndex:1].text;
        [self.datas insertObject:mod atIndex:row];
        NSIndexPath * idx=[NSIndexPath indexPathForRow:row inSection:0];
        [self.tv insertRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if([@"new name" isEqualToString:mes]&&buttonIndex==1){
        [_datas[alertView.tag] setValue:[alertView textFieldAtIndex:0].text forKeyPath:@"name"];
        [self.tv reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:alertView.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}





-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hfv=nil;
    if(!section){
        hfv=_header;
        if(!hfv){
            hfv=[[UIView alloc] init];
            hfv.backgroundColor=[UIColor colorWithRed:.3 green:.5 blue:.7 alpha:1];
            CGSize size=self.tv.bounds.size;
            UIButton *(^createBtn)(CGRect)=^(CGRect fra){
                UIButton *b=[[UIButton alloc] initWithFrame:fra];
                [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [b setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                b.titleLabel.font=[UIFont systemFontOfSize:14];
                [b setBackgroundColor:[UIColor colorWithRed:.3 green:.5 blue:.2 alpha:1]];
                return b;
            };
            CGRect recs[]={CGRectMake(size.width-130, 1, 50, 23),CGRectMake(size.width-70, 1, 50, 23)};
            NSInteger tags[]={UITableViewCellEditingStyleInsert,
            UITableViewCellEditingStyleDelete};
            for(int i=0;i<=1;i++){
                 UIButton *btn=createBtn(recs[i]);
                btn.tag=tags[i];
                [hfv addSubview:btn];
                [btn addTarget:self  action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                btns[i]=btn;
            }
            [self updateBnts:nil];
            _header=hfv;
        }
    }
    
    return hfv;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _edisty;
}

-(void)onBtnClicked:(UIButton *)sender{
    NSInteger tag=sender.tag;
    if(tag==_edisty){
        self.tv.editing=NO;
        _edisty=0;
        [self updateBnts:nil];
    }else{
        _edisty=tag;
        self.tv.editing=YES;
        [self.tv reloadData];
        [self updateBnts:sender];
    }
    
}


-(void) updateBnts:(UIButton *)btn{
     NSString *tit[]={@"add",@"del"};
    for(int i=0;i<2;i++){
        if(btns[i]==btn){
            [btn setTitle:@"over" forState:UIControlStateNormal];
        }else{
            [btns[i] setTitle:tit[i] forState:UIControlStateNormal];
        }
    }
    
}
@end
