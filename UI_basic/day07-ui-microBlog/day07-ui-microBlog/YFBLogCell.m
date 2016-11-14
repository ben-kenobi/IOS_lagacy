//
//  YFBLogCell.m
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBLogCell.h"
#import "YFBlogF.h"
#import "YFMicroBlog.h"

@interface YFBLogCell ()


@end

@implementation YFBLogCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
        [self setClipsToBounds:YES];
        
    }
    return self;
}


-(void)setBlogF:(YFBlogF *)blogF{
    _blogF=blogF;
    [self updateData ];
    [self updateFrame];
}

-(void)updateData{
    self.icon.image=[UIImage imageNamed:_blogF.blog.icon];
    self.pic.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:_blogF.blog.picture ofType:nil]];
    self.text.text=_blogF.blog.text;
    self.name.text=_blogF.blog.name;
    if([_blogF.blog isVip]){
        self.vip.image=[UIImage imageNamed:@"vip"];
        self.name.textColor=[UIColor redColor];
        self.vip.hidden=NO;
    }else{
        self.vip.hidden=YES;
        self.name.textColor=[UIColor blackColor];
    }
}
-(void)updateFrame{
    self.text.frame=_blogF.textF;
    self.icon.frame=_blogF.iconF;
    self.name.frame=_blogF.nameF;
    self.pic.frame=_blogF.picF;
    self.vip.frame=_blogF.vipF;
}


-(void) initUI{
    
    UIImageView *(^createIv)()=^{
        return [[UIImageView alloc] init];
    };
    UIImageView *pic=createIv();
    [self.contentView addSubview:pic];
    self.pic=pic;
    
    UIImageView *icon=createIv();
    [self.contentView addSubview:icon];
    self.icon=icon;
    
    UIImageView *vip=createIv();
    [self.contentView addSubview:vip];
    self.vip=vip;
    
    UILabel *(^createLab)()=^{
        return [[UILabel alloc] init];
    };
    
    UILabel *text=createLab();
    [self.contentView addSubview:text];
    self.text=text;
    [self.text setNumberOfLines:0];
    
    UILabel *name=createLab();
    [self.contentView addSubview:name];
    self.name=name;
    
}


@end
