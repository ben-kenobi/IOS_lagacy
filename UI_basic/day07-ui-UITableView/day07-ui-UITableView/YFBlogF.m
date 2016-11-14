//
//  YFBlogF.m
//  day07-ui-UITableView
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogF.h"
#import "YFBlog.h"

@implementation YFBlogF

-(instancetype)initWithblog:(YFBlog *)blog wid:(CGFloat)wid{
    if(self=[super init]){
        self.wid=wid;
        self.blog=blog;
    }
    return self;
}

+(instancetype)blogFWithblog:(YFBlog *)blog wid:(CGFloat)wid{
    return [[self alloc] initWithblog:blog wid:wid];
}

-(void)setBlog:(YFBlog *)blog{
    _blog=blog;
    [self updateF];
}

-(void)updateF{
    CGFloat padding=10,
    iconX=60;
    
    _iconF=(CGRect){padding,padding,iconX,iconX};
    
    CGSize namesize=[_blog.name boundingRectWithSize:CGSizeMake(_wid-padding*4-iconX, iconX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _nameF=(CGRect){CGRectGetMaxX(_iconF)+padding,padding,namesize};
    
    _vipF=(CGRect){CGRectGetMaxX(_nameF)+padding,padding,20,20};
    
    CGSize textsize=[_blog.text boundingRectWithSize:CGSizeMake(_wid-padding*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _textF=(CGRect){padding,CGRectGetMaxY(_iconF)+padding,textsize};
    
    _height=CGRectGetMaxY(_textF)+padding;
    
    if(_blog.picture){
        UIImage *img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:_blog.picture ofType:nil]];
        CGSize size=img.size;
        if(_wid-padding*2<size.width){
            size.height=(_wid-padding*2)/size.width*size.height;
            size.width=_wid-padding*2;
        }
        _picF=(CGRect){padding,_height,size};
        _height=CGRectGetMaxY(_picF);
        
    }
    
    
}


@end
