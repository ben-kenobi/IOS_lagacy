//
//  YFTgCell.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgCell.h"
#import "YFTgF.h"
#import "YFTg.h"

@interface YFTgCell ()
@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak)UILabel *title;
@property (nonatomic,weak)UILabel *price;
@property (nonatomic,weak)UILabel *buyCount;

@end

@implementation YFTgCell

-(void)setTgf:(YFTgF *)tgf{
    _tgf=tgf;
    [self updateUI];
}
-(void)updateUI{
    self.icon.image=[UIImage imageNamed:_tgf.tg.icon];
    self.icon.frame=_tgf.iconF;
    
    self.title.text=_tgf.tg.title;
    self.title.frame=_tgf.titleF;
    
    self.price.text=[NSString stringWithFormat:@"¥%@",_tgf.tg.price];
    self.price.frame=_tgf.priceF;
    
    self.buyCount.text=[NSString stringWithFormat:@"buyCount:%@",_tgf.tg.buyCount];
    self.buyCount.frame=_tgf.buyCountF;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}


-(void)initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    [self.contentView addSubview:icon];
    self.icon=icon;
    
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    
    self.title=createLab(self.contentView);
    self.price=createLab(self.contentView);
    self.buyCount=createLab(self.contentView);
    
    self.price.font=[UIFont systemFontOfSize:13];
    [self.price setTextColor:[UIColor orangeColor]];
    
    self.buyCount.font=[UIFont systemFontOfSize:13];
    [self.buyCount setTextColor:[UIColor grayColor]];
}
@end
