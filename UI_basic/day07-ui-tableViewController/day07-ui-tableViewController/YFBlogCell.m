//
//  YFBlogCell.m
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
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
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIImageView *(^createImg)(UIView *)=^(UIView *supV){
        UIImageView *iv=[[UIImageView alloc] init];
        [supV addSubview:iv];
        return iv;
    };
    self.pic=createImg(self.contentView);
    self.icon=createImg(self.contentView);
    self.vip=createImg(self.contentView);
    
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        return lab;
    };
    self.text=createLab(self.contentView);
    [self.text setNumberOfLines:0];
    self.name=createLab(self.contentView);
}


-(void)setBlogf:(YFBlogF *)blogf{
    _blogf=blogf;
    [self updateUI];
}
-(void)updateUI{
    self.icon.frame=_blogf.iconF;
    self.icon.image=[UIImage imageNamed:_blogf.blog.icon];
    
    self.name.frame=_blogf.nameF;
    self.name.text=_blogf.blog.name;
    
    if([_blogf.blog isVip]){
        self.vip.frame=_blogf.vipF;
        self.vip.image=[UIImage imageNamed:@"vip"];
        self.vip.hidden=NO;
        [self.name setTextColor:[UIColor redColor]];
    }else{
        [self.name setTextColor:[UIColor blackColor]];
        self.vip.hidden=YES;
    }
    
    self.text.frame=self.blogf.textF;
    self.text.text=_blogf.blog.text;
    
    if(self.blogf.blog.picture){
        self.pic.frame=_blogf.picF;
        
        self.pic.image=[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:self.blogf.blog.picture ofType:nil]];
        self.pic.hidden=NO;
    }else{
        self.pic.hidden=YES;
    }
}


@end
