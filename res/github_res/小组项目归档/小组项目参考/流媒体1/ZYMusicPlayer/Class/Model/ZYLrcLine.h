//
//  ZYLrcLine.h
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/12.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYMusic;
@interface ZYLrcLine : NSObject
/**
 *  时间点
 */
@property (nonatomic, copy) NSString *time;
/**
 *  词
 */
@property (nonatomic, copy) NSString *word;
/**
 *  返回所有的歌词model
 *
 */
+ (NSMutableArray *)lrcLinesWithFileName:(NSString *)fileName;
@end
