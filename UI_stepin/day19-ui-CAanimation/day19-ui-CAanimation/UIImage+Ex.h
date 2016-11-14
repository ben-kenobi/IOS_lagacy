//
//  UIImage+Ex.h
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
CGMutablePathRef shapePath(CGSize size,NSInteger count,NSInteger step,NSInteger multi);
@interface UIImage (Ex)
+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color count:(NSInteger)count multi:(NSInteger)multi step:(NSInteger)step drawType:(int)type;
@end
