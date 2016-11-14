//
//  ZYLrcLineTests.m
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/29.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZYLrcLine.h"
@interface ZYLrcLineTests : XCTestCase

@end

@implementation ZYLrcLineTests

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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
/**
 *  测试歌词是否正确被解析
 */
- (void)testLrcLinesWithFileName
{
//    10736444.lrc
    NSArray *lrcs = @[@"简单爱", @"作词：徐若瑄  作曲：周杰伦", @"像这样的生活 我爱你 你爱我", @"像这样的生活 我爱你 你爱我"];
    NSArray *times = @[@"00:-0.91", @"00:31.03", @"00:55.66", @"02:24.78", @"02:53.88"];
    
    NSArray *lrcLines = [ZYLrcLine lrcLinesWithFileName:@"10736444.lrc"];
    XCTAssert(lrcLines, @"lrcLinesWithFileName ouccer error, return array is nil");
    
    __block int lrcsIndex = 0;
    __block int timesIndex = 0;
    [lrcLines enumerateObjectsUsingBlock:^(ZYLrcLine *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (lrcsIndex < lrcs.count && [obj.word isEqualToString:lrcs[lrcsIndex]]) {
            lrcsIndex ++;
        }
        
        if (timesIndex < times.count && [obj.time isEqualToString:times[timesIndex]]) {
            timesIndex ++;
        }
    }];
    XCTAssertEqual(lrcsIndex, lrcs.count, @"lrcLinesWithFileName ouccer error, lose some word");
    XCTAssertEqual(timesIndex, times.count, @"lrcLinesWithFileName ouccer error, lose some time");
}
@end
