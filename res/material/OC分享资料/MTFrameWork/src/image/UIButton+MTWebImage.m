//
//  MTButton.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "UIButton+MTWebImage.h"
#import "UIButton+WebCache.h"

@implementation UIButton (MTWebImage)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImageWithURL:(NSURL *)url {
    [self setImageURL:[NSURL URLWithString:url]];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self setImageURL:url placeholderImage:placeholder];
}

@end
