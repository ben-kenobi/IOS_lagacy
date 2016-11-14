//
//  MTWebImageManager.m
//  MTFrameWork
//
//  Created by qiruihua(qiruihua@live.cn) on 12-9-7.
//  Copyright (c) 2012年 MTime. All rights reserved.
//

#import "MTWebImageManager.h"
#import "SynthesizeSingleton.h"
#import "SDWebImageManager.h"
#import "MTWebImageDownloader.h"

static const NSInteger kWebImageManagerDefaultMaxThread = 5;

@interface MTWebImageManager()

/**
 * called by downloader, to inform manager to remove it from list
 */
- (void)downloadFinishedWithDownloader:(MTWebImageDownloader *)downloader;

/**
 * put into the request into pending list and wait for kick off
 */
- (void)downloadImage:(NSURL *)url withDelegate:(id<MTWebImageDelegate>)delegate;

/**
 * start next round of downloading
 */
- (void)kickOffNextDownload;

/**
 * cancel given request with url
 */
- (void)cancelDownloadUrl:(NSURL *)url;

@end

@implementation MTWebImageManager

@synthesize maxThreadNumber = _maxThreadNumber;

SYNTHESIZE_SINGLETON_FOR_CLASS(MTWebImageManager);

- (id)init {
    self = [super init];
    if (self) {
        _requestList = [[NSMutableArray alloc] init];
        _downloadingList = [[NSMutableArray alloc] init];
        _maxThreadNumber = kWebImageManagerDefaultMaxThread;
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequest];
    [_requestList release];
    [_downloadingList release];
    [super dealloc];
}

+ (void)downloadImage:(NSURL *)url withDelegate:(id<MTWebImageDelegate>)delegate {
    [[MTWebImageManager sharedInstance] downloadImage:url withDelegate:delegate];
}

- (void)downloadImage:(NSURL *)url withDelegate:(id<MTWebImageDelegate>)delegate {
    @synchronized(self) {
        MTWebImageDownloader *downloader = [[MTWebImageDownloader alloc] init];
        downloader.delegate = delegate;
        downloader.url = url;
        [_requestList addObject:downloader];
        [self kickOffNextDownload];
    }
}

+ (void)cancelDownloadUrl:(NSURL *)url {
    [[MTWebImageManager sharedInstance] cancelDownloadUrl:url];
}

- (void)cancelDownloadUrl:(NSURL *)url {
    @synchronized(self) {
        for (MTWebImageDownloader *downloader in _downloadingList) {
            if ([[downloader.url absoluteString] compare:[url absoluteString]] == NSOrderedSame) {
                [downloader cancel];
                [_downloadingList removeObject:downloader];
            }
        }
        for (MTWebImageDownloader *downloader in _requestList) {
            if ([[downloader.url absoluteString] compare:[url absoluteString]] == NSOrderedSame) {
                [_requestList removeObject:downloader];
            }
        }
    }
}

+ (void)cancelDownloadWithDelegate:(id<MTWebImageDelegate>)delegate {
    [[self sharedInstance] cancelDownloadWithDelegate:delegate];
}

- (void)cancelDownloadWithDelegate:(id<MTWebImageDelegate>)delegate {
    @synchronized(self) {
        for (MTWebImageDownloader *downloader in _requestList) {
            if (downloader.delegate == delegate) {
                [_requestList removeObject:downloader];
            }
        }
        for (MTWebImageDownloader *downloader in _downloadingList) {
            if (downloader.delegate == delegate) {
                [_downloadingList removeObject:downloader];
                [downloader cancel];
            }
        }

    }
}

- (void)cancelAllRequest {
    @synchronized(self) {
        [_requestList removeAllObjects];
        for (MTWebImageDownloader *downloader in _downloadingList) {
            [downloader cancel];
        }
        [_downloadingList removeAllObjects];
    }
}

- (void)downloadFinishedWithDownloader:(MTWebImageDownloader *)downloader {
    @synchronized(self) {
        [_downloadingList removeObject:downloader];
        [self kickOffNextDownload];
    }
}

- (void)kickOffNextDownload {
    while (self.maxThreadNumber >= [_downloadingList count]) {
        if (0 >= [_requestList count]) {
            break;
        }
        MTWebImageDownloader *downloader = [_requestList objectAtIndex:0];
        [_requestList removeObjectAtIndex:0];
        [_downloadingList addObject:downloader];
        [downloader start];
    }
}

@end
