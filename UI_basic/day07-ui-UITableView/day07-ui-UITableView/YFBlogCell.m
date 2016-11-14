//
//  YFBlogCell.m
//  day07-ui-UITableView
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogCell.h"
#import "YFBlogF.h"
#import "YFBlog.h"

@interface YFBlogCell ()
@property (nonatomic,weak) UIImageView *pic;
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UIImageView *vip;
@property (nonatomic,weak) UILabel *text;
@property (nonatomic,weak) UILabel *name;

@end


@implementation YFBlogCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)setBlogf:(YFBlogF *)blogf{
    _blogf=blogf;
    [self updateUI];
    
}


-(void)updateUI{
    self.icon.image=[UIImage imageNamed:_blogf.blog.icon];
    self.icon.frame=_blogf.iconF;
    
    self.name.text=_blogf.blog.name;
    self.name.frame=_blogf.nameF;
    
    self.text.text=_blogf.blog.text;
    self.text.frame=_blogf.textF;
    
    if([_blogf.blog isVIp]){
        self.name.textColor=[UIColor redColor];
        self.vip.frame=_blogf.vipF;
        self.vip.hidden=NO;
    }else{
        self.vip.hidden=YES;
        self.name.textColor=[UIColor blackColor];
    }
    
    if(_blogf.blog.picture){
        self.pic.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:_blogf.blog.picture ofType:nil]];
        self.pic.frame=_blogf.picF;
        self.pic.hidden=NO;
    }else{
        self.pic.hidden=YES;
    }
}

-(void)initUI{
    UIImageView *(^creatIV)(UIView *)=^(UIView *supV){
        UIImageView *imgv=[[UIImageView alloc] init];
        [supV addSubview:imgv];
        return imgv;
    };
    self.pic=creatIV(self.contentView);
    self.icon=creatIV(self.contentView);
    self.vip=creatIV(self.contentView);
    self.vip.image=[UIImage imageNamed:@"vip"];
    
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    self.text=createLab(self.contentView);
    self.text.font=[UIFont systemFontOfSize:14];
    [self.text setNumberOfLines:0];
    self.name=createLab(self.contentView);
}

@end
