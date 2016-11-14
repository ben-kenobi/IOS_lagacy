//
//  ZYLrcCell.m
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/24.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import "ZYLrcCell.h"
#import "ZYLrcLine.h"
static NSString *_identifier = @"ZYLrcCell";
@implementation ZYLrcCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    ZYLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:_identifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.numberOfLines = 0;
    }
    return self;
}

- (void)setLrcLine:(ZYLrcLine *)lrcLine
{
    _lrcLine = lrcLine;
    self.textLabel.text = lrcLine.word;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.bounds = self.bounds;
}
@end
