//
//  MTImageView.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "UIImageView+MTWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (MTWebImage)

- (void)setImageWithURL:(NSURL *)url {
    [self setImageURL:url];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self setImageURL:url placeholderImage:placeholder];
}

@end
