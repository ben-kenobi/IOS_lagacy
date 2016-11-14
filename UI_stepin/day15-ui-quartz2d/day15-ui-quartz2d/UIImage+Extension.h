//
//  UIImage+Extension.h
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

CGMutablePathRef shapePath(CGSize size,NSInteger count,NSInteger step,NSInteger multi);


@interface UIImage (Extension)
+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color angle:(NSInteger)angle line:(NSInteger)line drawtype:(int)type anglestep:(NSInteger)astep linestep:(NSInteger)lstep;
+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color angle:(NSInteger)angle multi:(NSInteger)multi drawtype:(int)type step:(NSInteger)step;
@end
