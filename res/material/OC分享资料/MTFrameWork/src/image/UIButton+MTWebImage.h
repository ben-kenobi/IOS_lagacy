//
//  MTWebImageManager.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MTWebImage)

/**
 * Set the imageView `image` with an `url`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)setImageWithURL:(NSURL *)url;

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see setImageWithURL:placeholderImage:options:
 */
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
