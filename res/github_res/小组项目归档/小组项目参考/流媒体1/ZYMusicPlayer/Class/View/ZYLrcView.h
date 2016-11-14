//
//  ZYLrcView.h
//  ZYMusicPlayer
//
//  Created by 王志盼 on 15/10/24.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLrcView : UIImageView
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, copy) NSString *fileName;
@end
