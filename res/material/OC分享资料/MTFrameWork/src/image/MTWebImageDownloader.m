//
//  MTWebImageDownloader.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-17.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "MTWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "MTWebImageManager.h"

@implementation MTWebImageDownloader

@synthesize delegate = _delegate;
@synthesize url = _url;

- (void)start {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelForDelegate:self];
    if (self.url) {
        [manager downloadWithURL:self.url delegate:self];
    }
}

- (void)cancel {
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image forURL:(NSURL *)url {
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(webImageDidFinished:forURL:)]) {
        [self.delegate performSelector:@selector(webImageDidFinished:forURL:) withObject:image
                            withObject:url];
    }
    [[MTWebImageManager sharedInstance] performSelector:@selector(downloadFinishedWithDownloader:)
                                             withObject:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error forURL:(NSURL *)url {
    
}

@end
