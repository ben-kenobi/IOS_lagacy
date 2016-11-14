
//
//  YFBlogCell.m
//  day10-ui-blogautolayout2
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogCell.h"

@interface YFBlogCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation YFBlogCell

+(instancetype)cellWithTv:(UITableView *)tv andMod:(YFBlog *)blog{
    static NSString *iden=@"blogcelliden";
    YFBlogCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
   
    [cell setBlog:blog];
    
    return cell;
}

-(void)setBlog:(YFBlog *)blog{
    _blog=blog;
    [self updateUI];
}

-(void)updateUI{
    _icon.image=[UIImage imageNamed:_blog.icon];
    _name.text=_blog.name;
    _text.text=_blog.text;
    if(_blog.vip){
        _vip.hidden=NO;
        [_name setTextColor:[UIColor redColor]];
    }else{
        _vip.hidden=YES;
        [_name setTextColor:[UIColor blackColor]];
    }
    if(_blog.picture){
        _pic.image=[UIImage imageNamed:_blog.picture];
        _height.constant=100;
    }else{
        _pic.image=nil;
        _height.constant=0;
        
    }
    
    
}

@end
