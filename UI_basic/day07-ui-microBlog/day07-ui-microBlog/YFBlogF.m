//
//  YFBlogF.m
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBlogF.h"
#import "YFMicroBlog.h"

@implementation YFBlogF


-(instancetype)initWithBlog:(YFMicroBlog *)blog wid:(CGFloat)wid{
    if(self=[super init]){
        _wid=wid;
        self.blog=blog;
    }
    return self;
}
+(instancetype)blogFWithBlog:(YFMicroBlog *)blog wid:(CGFloat)wid{
    return [[self alloc] initWithBlog:blog wid:wid];
}


-(void)setBlog:(YFMicroBlog *)blog{
    _blog=blog;
    [self initFrames];
    
}

-(void)initFrames{
    CGFloat padding=10,iconWid=60;
    
    _iconF=CGRectMake(padding,padding,iconWid,iconWid);
    
    CGFloat nameX=CGRectGetMaxX(_iconF)+padding;
    CGSize nameSize=[self.blog.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat nameY=padding+(iconWid-nameSize.height)/2;
    _nameF=(CGRect){nameX, nameY,nameSize};
    
    
    _vipF=(CGRect){CGRectGetMaxX(_nameF)+padding,_nameF.origin.y,20,20};
    
    CGSize textSize=[self.blog.text boundingRectWithSize:CGSizeMake(_wid-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    
    
    _textF=(CGRect){padding,CGRectGetMaxY(_iconF)+padding,textSize};
    
    if(self.blog.picture){
        _picF=(CGRect){padding,CGRectGetMaxY(_textF)+padding,100,60};
        _height=CGRectGetMaxY(_picF)+padding;
    }else{
        _height=CGRectGetMaxY(_textF)+padding;
    }

}

@end
