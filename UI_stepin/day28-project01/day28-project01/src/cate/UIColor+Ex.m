//
//  UIColor+Extension.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIColor+Ex.h"




@implementation UIColor (Ex)
+(instancetype)randomColor{
    return [self colorWithRed:[self randomFloat:255] green:[self randomFloat:255] blue:[self randomFloat:255] alpha:1];
}

+(CGFloat)randomFloat:(NSInteger)base{
    return arc4random()%(base+1)/(base*1.0);
}
+(instancetype)rgba:(NSArray *)rgba{
    return [UIColor colorWithRed:[rgba[0] floatValue] green:[rgba[1] floatValue] blue:[rgba[2] floatValue] alpha:[rgba[3] floatValue]];
}


@end
