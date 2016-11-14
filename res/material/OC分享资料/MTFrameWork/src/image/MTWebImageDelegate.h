//
//  MTWebImageDelegate.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTWebImageManager;

@protocol MTWebImageDelegate <NSObject>

/**
 * this will be called when image downloaded and decoded successfully
 */
- (void)webImageDidFinished:(UIImage *)image forURL:(NSURL *)url;

/**
 * this will be called when image downloading or decoding failed
 */
- (void)webImageDidFailed:(NSError *)error forURL:(NSURL *)url;

@end
