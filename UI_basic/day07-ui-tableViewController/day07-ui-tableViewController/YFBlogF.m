//
//  YFBlogF.m
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogF.h"
#import "YFBlog.h"

@implementation YFBlogF

-(instancetype)initWithBlog:(YFBlog *)blog wid:(CGFloat)wid{
    if(self=[super init]){
         _wid=wid;
        self.blog=blog;
       
    }
    return self;
}

+(instancetype)blogFWithBlog:(YFBlog *)blog wid:(CGFloat)wid{
    return [[self alloc] initWithBlog:blog wid:wid];
}

-(void)setBlog:(YFBlog *)blog{
    _blog=blog;
    [self initFrame];
}
-(void)initFrame{
    CGFloat padding=10;
    CGFloat iconWid=60;
    _iconF=(CGRect){padding,padding,iconWid,iconWid};
    
    CGSize namesize=[self.blog.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat nameY=(iconWid-namesize.height)/2+padding;
    _nameF=(CGRect){CGRectGetMaxX(_iconF)+padding,nameY,namesize};
    
    _vipF=(CGRect){CGRectGetMaxX(_nameF)+padding,nameY,20,20};
    
    CGSize textSize=[self.blog.text boundingRectWithSize:CGSizeMake(_wid-padding*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _textF=(CGRect){padding,CGRectGetMaxY(_iconF)+padding,textSize};
    
    if(self.blog.picture){
        _picF=(CGRect){padding,CGRectGetMaxY(_textF)+padding,80,80};
        _height=CGRectGetMaxY(_picF)+padding;
    }else{
        _height=CGRectGetMaxY(_textF);
    }
    
    
    
}


@end
