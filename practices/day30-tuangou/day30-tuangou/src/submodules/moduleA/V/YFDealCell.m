//
//  YFDealCell.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDealCell.h"
#import "TFDeal.h"
#import "UIImageView+WebCache.h"

@interface YFDealCell ()
@property (weak, nonatomic)  UIImageView *imageView;
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UILabel *descLabel;
@property (weak, nonatomic)  UILabel *currentPriceLabel;
@property (weak, nonatomic)  UILabel *listPriceLabel;
@property (weak, nonatomic)  UILabel *purchaseCountLabel;

@property (weak, nonatomic)  UIImageView *dealNewView;
@property (weak, nonatomic)  UIButton *cover;

@property (weak, nonatomic)  UIImageView *checkView;


@end

@implementation YFDealCell



-(void)initUI{
    UIImageView *imageView=[[UIImageView alloc] initWithImage:img(@"placeholder_deal")];
    self.imageView=imageView;
    [self addSubview:imageView];
    CGFloat pad=5,pad2=10;;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(pad));
        make.right.equalTo(@(-pad));
        make.top.equalTo(@(pad));
        make.height.equalTo(@185);
    }];

    UIView *textArea=[[UIView alloc] init];
    [self addSubview:textArea];
    [textArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(pad2));
        make.right.equalTo(@(-pad2));
        make.bottom.equalTo(@(-pad2));
        make.top.equalTo(imageView.mas_bottom).offset(pad2);
    }];
    UILabel *(^newLab)(UIView *,UIFont *,UIColor *)=^(UIView *sup,UIFont *font,UIColor *color){
        UILabel *lab=[[UILabel alloc] init];
        [lab setFont:font];
        [lab setTextColor:color];
        [sup addSubview:lab];
        return lab;
    };
    
    self.titleLabel=newLab(textArea,[UIFont systemFontOfSize:19],[UIColor blackColor]);
    self.descLabel=newLab(textArea,[UIFont systemFontOfSize:13],[UIColor grayColor]);
    [self.descLabel setNumberOfLines:2];
    self.currentPriceLabel=newLab(textArea,[UIFont systemFontOfSize:18],[UIColor redColor] );
    self.listPriceLabel=newLab(textArea,[UIFont systemFontOfSize:10],[UIColor grayColor]);
    self.purchaseCountLabel=newLab(textArea,[UIFont systemFontOfSize:11],[UIColor grayColor]);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.right.equalTo(@0);
        
    }];
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
    }];
    [self.listPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(self.currentPriceLabel.mas_right).offset(7);
    }];
    [self.purchaseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
    }];

    UIImageView *dealnew=[[UIImageView alloc] initWithImage:img(@"ic_deal_new")];
    [self addSubview:dealnew];
    self.dealNewView=dealnew;
    [dealnew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
    }];
    
    UIButton *cover=[[UIButton alloc] init];
    [self addSubview:cover];
    self.cover=cover;
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [cover addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *checkV=[[UIImageView alloc] initWithImage:img(@"ic_choosed")];
    self.checkView=checkV;
    [self addSubview:checkV];
    [checkV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
    }];
    
}


-(void)setDeal:(TFDeal *)deal{
    _deal=deal;
    [self.imageView sd_setImageWithURL:iURL(deal.s_image_url) placeholderImage:img(@"placehoder_deal") options:0 progress:0 completed:0];
    self.titleLabel.text=deal.title;
    self.descLabel.text=deal.desc;
    
    self.purchaseCountLabel.text=[NSString stringWithFormat:@"已售%d",deal.purchase_count];
    self.currentPriceLabel.text=[NSString stringWithFormat:@"¥ %@",deal.current_price];
    NSInteger dotLoc =[self.currentPriceLabel.text rangeOfString:@"."].location;
    if(dotLoc!=NSNotFound){
        if(self.currentPriceLabel.text.length-dotLoc>3){
            self.currentPriceLabel.text=[self.currentPriceLabel.text substringFromIndex:dotLoc+3];
        }
    }
    
    self.listPriceLabel.text=[NSString stringWithFormat:@"¥ %@",deal.list_price];
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *nowStr=[fmt stringFromDate:[NSDate date]];
    self.dealNewView.hidden=([deal.publish_date compare:nowStr]<0);
    self.cover.hidden=!deal.isEditting;
    self.checkView.hidden=!deal.isChecking;
    
}


-(void)onClicked:(id)sender{
    self.deal.checking=!self.deal.checking;
    self.checkView.hidden= !self.deal.checking;
    if(self.onCellStateChange){
        [self onCellStateChange ](self);
    }
}



-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    [img(@"bg_dealcell") drawInRect:rect];
}
@end
