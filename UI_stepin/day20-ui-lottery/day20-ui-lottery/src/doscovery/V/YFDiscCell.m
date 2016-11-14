//
//  YFDiscCell.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDiscCell.h"
#import "Masonry.h"

@interface YFDiscCell ()

@property (nonatomic,weak)UIImageView *imgl;
@property (nonatomic,weak)UIImageView *imgr;
@property (nonatomic,weak)UILabel *lab;
@end

@implementation YFDiscCell



+(instancetype)cellWithTv:(UITableView *)tv dict:(NSDictionary *)dict{
    static  NSString *iden=@"disccelliden";
    YFDiscCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[YFDiscCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    [cell setDict:dict];
    return cell;
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}
-(void)updateUI{
    self.lab.text=self.dict[@"title"];
    self.imgl.image=[UIImage imageNamed:self.dict[@"imgl"]];
    self.imgr.image=[UIImage imageNamed:self.dict[@"imgr"]];
    
}


-(UILabel *)lab{
    if(!_lab){
        UILabel *lab=[[UILabel alloc] init];
        [lab setTextColor:[UIColor grayColor]];
        [lab setFont:[UIFont systemFontOfSize:13]];
        [lab setNumberOfLines:0];
        [self addSubview:lab];
        self.lab=lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgl);
            make.bottom.equalTo(@-15);
            make.right.lessThanOrEqualTo(self.imgr.mas_left).offset(-5);
        }];

    }
    
    return _lab;
}

-(UIImageView *)imgr{
    if(!_imgr){
        UIImageView *iv=[[UIImageView alloc] init];
        [self addSubview:iv];
        self.imgr=iv;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(@0);
        }];
    }
    return _imgr;
}
-(UIImageView *)imgl{
    if(!_imgl){
        UIImageView *iv=[[UIImageView alloc] init];
        [self addSubview:iv];
        self.imgl=iv;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@7);
            make.left.equalTo(@20);
        }];
    }
    return _imgl;
}
@end
