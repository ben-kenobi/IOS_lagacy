//
//  YFBlogCell.m
//  day10-ui-blogAutolayout
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogCell.h"
#import "YFMicroBlog.h"
@interface YFBlogCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *pic;


@end


@implementation YFBlogCell


+(instancetype)cellWithTv:(UITableView *)tv blog:(YFMicroBlog *)blog{
    static NSString *iden=@"blogiden";
    YFBlogCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    [cell setBlog:blog];
    return cell;
}

-(void)setBlog:(YFMicroBlog *)blog{
    
    _blog=blog;
    _text.text=blog.text;
    _name.text=blog.name;
    _icon.image=[UIImage imageNamed:blog.icon];
    if(blog.picture){
        _pic.image=[UIImage imageNamed:blog.picture];
        
    }else{
        _pic.image=nil;
       
    }
    if(blog.vip){
        self.name.textColor=[UIColor redColor];
        
        _vip.hidden=NO;
    }else{
        _vip.hidden=YES;
        self.name.textColor=[UIColor blackColor];
    }
    
    
}

@end
