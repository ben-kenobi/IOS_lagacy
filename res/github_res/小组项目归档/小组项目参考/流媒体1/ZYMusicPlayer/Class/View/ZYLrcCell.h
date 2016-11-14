//
//  ZYLrcCell.h
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/24.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYLrcLine;
@interface ZYLrcCell : UITableViewCell
@property (nonatomic, strong) ZYLrcLine *lrcLine;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
@end
