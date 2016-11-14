//
//  YFColCell.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFColCell.h"
#import "Masonry.h"
@interface YFColCell ()
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak)UILabel *lab;

@end

@implementation YFColCell


-(void)initUI{
    UIImageView *icon=[[UIImageView alloc] init];
    self.icon=icon;
    [self addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(@0);
        make.height.width.equalTo(@60);
    }];
    icon.layer.cornerRadius=10;

    icon.layer.masksToBounds=YES;
    
    UILabel *lab=[[UILabel alloc] init];
    self.lab=lab;
    [lab setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(@0);

    }];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}
+(instancetype)cellWith:(UICollectionView *)cv path:(NSIndexPath *)path dict:(NSDictionary *)dict{
    YFColCell *cell=[cv dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:path];
    [cell setDict:dict];
    return cell;
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}

-(void)updateUI{
    self.lab.text=_dict[@"title"];
    self.icon.image=[UIImage imageNamed:_dict[@"icon"]];
}


@end
