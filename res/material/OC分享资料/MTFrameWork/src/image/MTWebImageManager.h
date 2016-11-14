//
//  MTWebImageManager.h
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTWebImageDelegate.h"

@interface MTWebImageManager : NSObject {
    NSMutableArray *_requestList; // pending downloading list
    NSMutableArray *_downloadingList; // currently downloading list
    NSInteger _maxThreadNumber;
}
@property (nonatomic) NSInteger maxThreadNumber;

+ (MTWebImageManager *)sharedInstance;

/**
 * download web image with url
 */
+ (void)downloadImage:(NSURL *)url withDelegate:(id<MTWebImageDelegate>)delegate;

/**
 * cancel the downloading for certain url
 * 
 */
+ (void)cancelDownloadUrl:(NSURL *)url;

+ (void)cancelDownloadWithDelegate:(id<MTWebImageDelegate>)delegate;

/**
 * cancel all downloding request
 */
- (void)cancelAllRequest;

@end

