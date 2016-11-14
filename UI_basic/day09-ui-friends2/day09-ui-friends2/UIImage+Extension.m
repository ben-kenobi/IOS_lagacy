//
//  UIImage+Extension.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

-(UIImage *)resizableImg{
    CGFloat w=self.size.width*.5,
    h=self.size.height*.5;
    return [self resizableImageWithCapInsets:(UIEdgeInsets){h,w,h,w} resizingMode:UIImageResizingModeStretch];
}

@end
