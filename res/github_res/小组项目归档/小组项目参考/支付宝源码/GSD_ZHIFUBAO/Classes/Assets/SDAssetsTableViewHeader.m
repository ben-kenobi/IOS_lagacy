//
//  SDAssetsTableViewHeader.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDAssetsTableViewHeader.h"

@implementation SDAssetsTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    SDAssetsTableViewHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"SDAssetsTableViewHeader" owner:self options:nil] lastObject];
    if (frame.size.width != 0) {
        header.frame = frame;
    }
    return header;
}

- (IBAction)rightTopButtonClicked {
}

- (IBAction)leftButtonClicked {
}

- (IBAction)rightButtonClicked {
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com