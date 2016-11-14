//
//  YFEmojiAta.m
//  day35-map
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFEmojiAta.h"

@implementation YFEmojiAta

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return (CGRect){0,-5,lineFrag.size.height,lineFrag.size.height};
}

@end
