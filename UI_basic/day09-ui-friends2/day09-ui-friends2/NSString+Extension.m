//
//  NSString+Extension.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSString+Extension.h"


@implementation NSString (Extension)

-(CGSize)boundWithSize:(CGSize)size andFonsize:(CGFloat)fontsize{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
}

@end
