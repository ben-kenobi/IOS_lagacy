//
//  ZYMusicCell.h
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/25.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYMusic;
@interface ZYMusicCell : UITableViewCell
@property (nonatomic, strong) ZYMusic *music;

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;
@end
