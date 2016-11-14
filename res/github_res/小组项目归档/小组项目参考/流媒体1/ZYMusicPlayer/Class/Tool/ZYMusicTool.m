//
//  ZYMusicTool.m
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/12.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import "ZYMusicTool.h"
#import "ZYMusic.h"
#import "MJExtension.h"
static NSArray *_musics;
static ZYMusic *_playingMusic;

@implementation ZYMusicTool

+ (NSArray *)musics
{
    if (_musics == nil) {
        _musics = [ZYMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

+ (ZYMusic *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(ZYMusic *)playingMusic
{
    if (playingMusic == nil || ![_musics containsObject:playingMusic] || playingMusic == _playingMusic) {
        return;
    }
    _playingMusic = playingMusic;
}


+ (ZYMusic *)nextMusic
{
    int nextIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return [self musics][nextIndex];
}

+ (ZYMusic *)previousMusic
{
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0) {
            previousIndex = (int)[self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}

@end
