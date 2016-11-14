//
//  YFAppCell.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAppCell.h"
#import "YFApp.h"
@interface YFAppCell ()
@property (nonatomic,weak)UIButton *btn;

@end


@implementation YFAppCell

+(instancetype)cellWithTv:(UITableView *)tv andMod:(YFApp *)mod{
    static NSString *iden=@"appcelliden";
    YFAppCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    [cell setMod:mod];
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.detailTextLabel.textColor=[UIColor grayColor];
        self.detailTextLabel.font=[UIFont systemFontOfSize:13];
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        [btn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitle:@"下载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"以下" forState:UIControlStateDisabled];
        [btn addTarget:self  action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.btn=btn;
        [self setAccessoryView:btn];
    }
    return self;
}

-(void)setMod:(YFApp *)mod{
    _mod=mod;
    [self updateUI];
    
}
-(void)updateUI{
    self.imageView.image=[UIImage imageNamed:_mod.icon];
    self.textLabel.text=_mod.name;
    self.detailTextLabel.text=[NSString stringWithFormat:@"以下载：%@，大小：%@",_mod.download,_mod.size];
    [self.btn setEnabled:!self.mod.downloaded];
    
}

-(void)onBtnClicked:(UIButton *)sender{
    self.mod.downloaded=YES;
    [self.btn setEnabled:NO];
}

@end
