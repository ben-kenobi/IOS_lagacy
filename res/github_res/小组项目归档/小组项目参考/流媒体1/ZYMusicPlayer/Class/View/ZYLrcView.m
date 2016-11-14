//
//  ZYLrcView.m
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/24.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import "ZYLrcView.h"
#import "ZYLrcLine.h"
#import "ZYLrcCell.h"
#import "UIView+AutoLayout.h"

@interface ZYLrcView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lrcLines;
/**
 *  记录当前显示歌词在数组里面的index
 */
@property (nonatomic, assign) int currentIndex;
@end

@implementation ZYLrcView

#pragma mark ----setter\geter方法

- (NSMutableArray *)lrcLines
{
    if (_lrcLines == nil) {
        _lrcLines = [ZYLrcLine lrcLinesWithFileName:self.fileName];
    }
    return _lrcLines;
}

- (void)setFileName:(NSString *)fileName
{
    if ([_fileName isEqualToString:fileName]) {
        return;
    }
    _fileName = [fileName copy];
    [_lrcLines removeAllObjects];
    _lrcLines = nil;
    [self.tableView reloadData];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (_currentTime > currentTime) {
        self.currentIndex = 0;
    }
    _currentTime = currentTime;
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    
    for (int i = self.currentIndex; i < self.lrcLines.count; i++) {
        ZYLrcLine *currentLine = self.lrcLines[i];
        NSString *currentLineTime = currentLine.time;
        NSString *nextLineTime = nil;
        
        if (i + 1 < self.lrcLines.count) {
            ZYLrcLine *nextLine = self.lrcLines[i + 1];
            nextLineTime = nextLine.time;
        }
        
        if (([currentTimeStr compare:currentLineTime] != NSOrderedAscending) && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending) && (self.currentIndex != i)) {
            
            
            NSArray *reloadLines = @[
                                     [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
                                     [NSIndexPath indexPathForItem:i inSection:0]
                                     ];
            self.currentIndex = i;
            [self.tableView reloadRowsAtIndexPaths:reloadLines withRowAnimation:UITableViewRowAnimationNone];
            
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }
}
#pragma mark ----初始化方法

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    self.userInteractionEnabled = YES;
    self.image = [UIImage imageNamed:@"28131977_1383101943208"];
    self.contentMode = UIViewContentModeScaleToFill;
    self.clipsToBounds = YES;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    [self addSubview:tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark ----UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYLrcCell *cell = [ZYLrcCell lrcCellWithTableView:tableView];
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    if (indexPath.row == self.currentIndex) {
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    NSLog(@"++++++++++%@",NSStringFromCGRect(self.tableView.frame));
    self.tableView.contentInset = UIEdgeInsetsMake(self.frame.size.height / 2, 0, self.frame.size.height / 2, 0);
}
@end
