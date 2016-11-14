//
//  YFNewsTVCellTableViewCell.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsTVCell.h"
#import "UIImageView+WebCache.h"
#import "YFNews.h"
@interface YFNewsTVCell ()
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *digest;
@property (nonatomic,strong)UILabel *replyCount;
@property (nonatomic,strong)UIImageView *iv;

@end

@implementation YFNewsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        id (^new)(UIView *,Class)=^(UIView *sup,Class clz){
            id obj=[[clz alloc] init];
            [sup addSubview:obj];
            return obj;
        };
        self.title=new(self.contentView, [UILabel class]);
        self.digest=new(self.contentView, [UILabel class]);
        self.replyCount=new(self.contentView, [UILabel class]);
        self.title.font=[UIFont systemFontOfSize:14];
        self.replyCount.font=[UIFont systemFontOfSize:12];
        self.digest.font=[UIFont systemFontOfSize:13];
        self.digest.textColor=[UIColor grayColor];
        self.digest.numberOfLines=2;
        self.replyCount.textColor=[UIColor grayColor];
        self.iv=new(self.contentView, [UIImageView class]);
        UIView *view=[[UIView alloc] init];
        [self.contentView addSubview:view];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@.5);
        }];
    }
    return self;
}


-(void)setNews:(YFNews *)news{
    _news=news;
    
    self.title.text=news.title;
    [self.title sizeToFit];
    self.digest.text=news.digest;
    self.replyCount.text=[NSString stringWithFormat:@"%@",news.replyCount ];
    [self.replyCount sizeToFit];
    [self.iv sd_setImageWithURL:iURL(news.imgsrc)];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat pad=8,imgw=100,imgh=self.h-pad*2;
    self.iv.frame=(CGRect){pad,pad,imgw,imgh};
    self.title.origin=(CGPoint){imgw+pad*2,pad};
    self.digest.frame=(CGRect){imgw+pad*2,pad+20,(self.w-imgw-pad*3),0};
    [self.digest sizeToFit];
    self.replyCount.r=self.w-pad;
    self.replyCount.b=self.h-pad;
}


@end
