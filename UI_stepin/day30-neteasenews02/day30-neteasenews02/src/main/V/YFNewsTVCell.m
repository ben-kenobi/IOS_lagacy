//
//  YFNewsTVCell.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsTVCell.h"
#import "YFNews.h"
#import "UIImageView+WebCache.h"

@interface YFNewsTVCell ()
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *digest;
@property (nonatomic,strong)UILabel *replyCount;
@property (nonatomic,strong)UIImageView *iv;
@end

@implementation YFNewsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

+(instancetype)cellWithTv:(UITableView *)tv news:(YFNews *)news{
    static NSString *const celliden=@"newstvcelliden";
    YFNewsTVCell *cell=[tv dequeueReusableCellWithIdentifier:celliden];
    if(!cell){
        cell=[[self alloc] initWithStyle:0 reuseIdentifier:celliden];
    }
    [cell setNews:news];
    return cell;
}

-(void)initUI{
    UILabel *(^newlab)(UIView *,UIFont *,UIColor *)=^(UIView *sup,UIFont *font,UIColor *color){
        UILabel *lab=[[UILabel alloc] init];
        lab.font=font;
        lab.textColor=color;
        [sup addSubview:lab];
        return lab;
    };
    self.title=newlab(self.contentView, [UIFont systemFontOfSize:14],[UIColor blackColor]);
    self.digest=newlab(self.contentView, [UIFont systemFontOfSize:13],[UIColor grayColor]);
    self.replyCount=newlab(self.contentView, [UIFont systemFontOfSize:12],[UIColor grayColor]);

    self.digest.numberOfLines=2;

    self.iv=[[UIImageView alloc] init];
    [self.contentView addSubview:self.iv];
    
    CGFloat pad=8;
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@(pad));
        make.bottom.equalTo(@(-pad));
        make.width.equalTo(@120);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(pad));
        make.leading.equalTo(self.iv.mas_right).offset(pad);
        make.right.lessThanOrEqualTo(@(-pad));
    }];
    
    [self.replyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@(-pad));
    }];
    
    [self.digest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(pad);
        make.leading.right.equalTo(self.title);
        make.bottom.equalTo(self.replyCount.mas_top).offset(3);
    }];
    
    
    
    UIView *view=[[UIView alloc] init];
    [self.contentView addSubview:view];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@.5);
    }];
}


-(void)setNews:(YFNews *)news{
    _news=news;
    [self updateUI];
}

-(void)updateUI{
    self.title.text=_news.title;
    [self.title sizeToFit];
    self.digest.text=_news.digest;
    self.replyCount.text=[NSString stringWithFormat:@"%@",_news.replyCount ];
    [self.replyCount sizeToFit];

    

    [self.iv sd_setImageWithURL:iURL(_news.imgsrc)];
}

@end
