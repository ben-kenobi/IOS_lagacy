//
//  HorizontalScrollCell.h
//  MoviePicker
//
//  Created by Muratcan Celayir on 28.01.2015.
//  Copyright (c) 2015 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScrollCellAction;
@protocol HorizontalScrollCellDelegate <NSObject>
-(void)cellSelected;
@end

@interface HorizontalScrollCell : UICollectionViewCell <UIScrollViewDelegate>
{
    CGFloat supW;
    CGFloat off;
    CGFloat diff;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) IBOutlet UILabel *title;
-(void)setUpCellWithArray:(NSArray *)array;

@property (nonatomic,strong) id<HorizontalScrollCellDelegate> cellDelegate;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com