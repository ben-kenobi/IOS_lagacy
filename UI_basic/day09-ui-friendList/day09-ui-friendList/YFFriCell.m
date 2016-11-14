//
//  YFFriCell.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFriCell.h"
#import "YFFriendF.h"
#import "YFFriend.h"

@interface YFFriCell ()
@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *intro;

@end

@implementation YFFriCell


+(instancetype)cellWithTv:(UITableView *)tv andFriF:(YFFriendF*)friF{
    static NSString *iden=@"friiden";
    YFFriCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(nil==cell)
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    
    [cell setFriF:friF];
    return cell;
}




-(void)setFriF:(YFFriendF *)friF{
    _friF=friF;
    [self updateUI];
}
-(void)updateUI{
    self.icon.image=[UIImage imageNamed:_friF.fri.icon];
    self.icon.frame=_friF.iconF;
    
    self.name.text=_friF.fri.name;
    self.name.frame=_friF.nameF;
    
    self.intro.text=_friF.fri.intro;
    self.intro.frame=_friF.introF;
    
    if(_friF.fri.isVip){
        [self.name setTextColor:[UIColor redColor]];
    }else
        [self.name setTextColor:[UIColor blackColor]];
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
        
    }
    return self;
}

-(void)initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    self.icon=icon;
    [self.contentView addSubview:icon];
    
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    
    self.name=createLab(self.contentView);
    self.intro=createLab(self.contentView);
    
    self.name.font=[UIFont boldSystemFontOfSize:17];
    self.intro.font=[UIFont systemFontOfSize:14];
    [self.intro setTextColor:[UIColor grayColor]];
    [self.intro setNumberOfLines:0];
}



@end
