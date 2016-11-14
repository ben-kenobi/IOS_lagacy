//
//  MTWebImageDownloader.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-17.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "MTWebImageManager.h"
#import "SDWebImageManagerDelegate.h"

@interface MTWebImageDownloader : NSObject <SDWebImageManagerDelegate> {
    id<MTWebImageDelegate> _delegate;
    NSURL *_url;
}
@property (nonatomic, assign) id<MTWebImageDelegate> delegate;
@property (nonatomic, retain) NSURL *url;

/**
 * start downloading
 */
- (void)start;

/**
 * cancel downloading
 */
- (void)cancel;

@end
