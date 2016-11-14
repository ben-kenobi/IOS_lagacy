//
//  ZYAudioManagerTests.m
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/16.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZYAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ZYAudioManagerTests : XCTestCase
@property (nonatomic, strong) AVAudioPlayer *player;
@end
static NSString *_fileName = @"10405520.mp3";
@implementation ZYAudioManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

/**
 *  测试是否为单例，要在并发条件下测试
 */
- (void)testAudioManagerSingle
{
    NSMutableArray *managers = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYAudioManager *tempManager = [[ZYAudioManager alloc] init];
        [managers addObject:tempManager];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYAudioManager *tempManager = [[ZYAudioManager alloc] init];
        [managers addObject:tempManager];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYAudioManager *tempManager = [[ZYAudioManager alloc] init];
        [managers addObject:tempManager];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYAudioManager *tempManager = [[ZYAudioManager alloc] init];
        [managers addObject:tempManager];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYAudioManager *tempManager = [[ZYAudioManager alloc] init];
        [managers addObject:tempManager];
    });
    
    ZYAudioManager *managerOne = [ZYAudioManager defaultManager];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [managers enumerateObjectsUsingBlock:^(ZYAudioManager *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XCTAssertEqual(managerOne, obj, @"ZYAudioManager is not single");
        }];
        
    });
}

/**
 *  测试是否可以正常播放音乐
 */
- (void)testPlayingMusic
{
    self.player = [[ZYAudioManager defaultManager] playingMusic:_fileName];
    XCTAssertTrue(self.player.playing, @"ZYAudioManager is not PlayingMusic");
}

/**
 *  测试是否可以正常停止音乐
 */
- (void)testStopMusic
{
    if (self.player == nil) {
        self.player = [[ZYAudioManager defaultManager] playingMusic:_fileName];
    }
    
    if (self.player.playing == NO) [self.player play];
    
    [[ZYAudioManager defaultManager] stopMusic:_fileName];
    XCTAssertFalse(self.player.playing, @"ZYAudioManager is not StopMusic");
}

/**
 *  测试是否可以正常暂停音乐
 */
- (void)testPauseMusic
{
    if (self.player == nil) {
        self.player = [[ZYAudioManager defaultManager] playingMusic:_fileName];
    }
    if (self.player.playing == NO) [self.player play];
    [[ZYAudioManager defaultManager] pauseMusic:_fileName];
    XCTAssertFalse(self.player.playing, @"ZYAudioManager is not pauseMusic");
}

@end
