//
//  YFBlogCell.m
//  day10-ui-blogmasonry
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogCell.h"
#import "Masonry.h"

@interface YFBlogCell ()

@end

@implementation YFBlogCell

+(instancetype)cellWithTv:(UITableView *)tv andBlog:(YFBlog *)blog{
    static NSString *iden=@"blogcelliden";
    YFBlogCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    [cell setBlog:blog];
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)setBlog:(YFBlog *)blog{
    _blog=blog;
    [self updateUI];
}

-(void)updateUI{
    self.icon.image=[UIImage imageNamed:_blog.icon];
    self.name.text=_blog.name;
    self.text.text=_blog.text;
    
    if(_blog.vip){
        self.vip.hidden=NO;
        self.name.textColor=[UIColor redColor];
        
    }else{
        self.vip.hidden=YES;
        self.name.textColor=[UIColor blackColor];
    }
    
    
    self.pic.image=[UIImage imageNamed:_blog.picture];
    if(!_blog.picture){
        [self.text mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }else{
        [self.text mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.pic.mas_top).offset(-10);
        }];
    }
    
}

-(void)initUI{
    UIImageView *(^createIv)(UIView *)=^(UIView *supV){
        UIImageView *iv=[[UIImageView alloc] init];
        [supV addSubview:iv];
        return iv;
    };
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    
    self.icon=createIv(self);
    self.vip=createIv(self);
    self.vip.image=[UIImage imageNamed:@"vip"];
    self.pic=createIv(self);
    self.name=createLab(self);
    self.text=createLab(self);
    [self.text setNumberOfLines:0];
    [self.text setFont:[UIFont systemFontOfSize:13]];
    
    
    CGFloat pad=10;
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(pad);
        make.height.width.mas_equalTo(60);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(pad);
        make.centerY.equalTo(self.icon.mas_centerY);
        make.height.equalTo(@20);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-30);
    }];
    
    [_vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(pad);
        make.centerY.equalTo(self.name.mas_centerY);
    }];
    
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(pad));
        make.right.equalTo(self.mas_right).offset(-pad);
        
        make.top.equalTo(self.icon.mas_bottom).offset(pad);
    
    }];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(pad));
        make.right.lessThanOrEqualTo(self.mas_right).offset(-pad);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.top.equalTo(self.text.mas_bottom).offset(10);
        make.height.lessThanOrEqualTo(self.mas_width).offset(-20);
    }];
    
}

@end
