//
//  ZYMusicTool.h
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/12.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYMusic;
@interface ZYMusicTool : NSObject
/**
 *  正在播放的歌曲
 *
 */
+ (ZYMusic *)playingMusic;
/**
 *  重新设置歌曲
 *
 */
+ (void)setPlayingMusic:(ZYMusic *)playingMusic;

/**
 *
 *
 *  @return 所有歌曲
 */
+ (NSArray *)musics;

/**
 *
 *  下一首歌曲
 */
+ (ZYMusic *)nextMusic;

/**
 *  上一首歌曲
 *
 */
+ (ZYMusic *)previousMusic;
@end
