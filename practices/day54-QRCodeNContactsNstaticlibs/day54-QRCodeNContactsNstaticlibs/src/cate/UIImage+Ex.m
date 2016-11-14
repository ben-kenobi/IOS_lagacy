//
//  UIImage+Ex.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIImage+Ex.h"
#import <ImageIO/ImageIO.h>

CGMutablePathRef shapePath(CGRect rect,NSInteger count,NSInteger step,NSInteger multi,CGFloat froma){
    if(!count) return 0;
    
    CGSize size=rect.size;
    CGPoint p=rect.origin;
    CGFloat cx=size.width*.5+p.x,cy=size.height*.5+p.y,
    rad=MIN(size.width,size.height)*.5;
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef patharc=CGPathCreateMutable();
    
    CGFloat from=froma,to=from,gap=2*M_PI/count;
    CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
    CGPoint cur=CGPathGetCurrentPoint(patharc);
    CGPathMoveToPoint(path, 0, cur.x, cur.y);
    
    for(int i=1;i<=step;i++){
        
        to=from+gap*multi;
        CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
        cur=CGPathGetCurrentPoint(patharc);
        CGPathAddLineToPoint(path, 0, cur.x, cur.y);
        from=to;
        
        if(!(i*multi%count)){
            to=from+gap;
            CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
            cur=CGPathGetCurrentPoint(patharc);
            CGPathMoveToPoint(path, 0, cur.x, cur.y);
            from=to;
        }
    }
    CGPathRelease(patharc);
    return path;
    
}

@implementation UIImage (Ex)

+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color count:(NSInteger)count multi:(NSInteger)multi step:(NSInteger)step drawType:(int)type{
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
   CGMutablePathRef path= shapePath((CGRect){0,0,size}, count, step, multi,0);
    CGContextAddPath(con,path );
    CGPathRelease(path);
    [color set];
    CGContextDrawPath(con, type);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


-(instancetype)resizableStretchImg{
    CGFloat  w=self.size.width*.5;
    CGFloat h=self.size.height*.5;
    return [self resizableImageWithCapInsets:(UIEdgeInsets){h,w,h,w} resizingMode:UIImageResizingModeStretch];
}



-(instancetype)clipBy:(int)idx count:(int)count scale:(CGFloat)scale{
    CGFloat h=self.size.height*iScreen.scale,
    w=self.size.width/count*iScreen.scale;
    CGImageRef ci=CGImageCreateWithImageInRect([self CGImage], (CGRect){idx*w,0,w,h});
    UIImage *img= [UIImage imageWithCGImage:ci  scale:scale orientation:0];
    CGImageRelease(ci);
    return img;

}

+(instancetype)imgFromV:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    [view.layer renderInContext:con];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(UIImage *)scaleImg2size:(CGSize)size{
    
    CGRect tar={0,0,size};
    if(!CGSizeEqualToSize(self.size, size)){
        CGFloat scale=MIN(size.width /self.size.width, size.height/self.size.height);
        tar.size.width=self.size.width*scale;
        tar.size.height=self.size.height*scale;
        tar.origin.x=(size.width-tar.size.width)*.5;
        tar.origin.y=(size.height-tar.size.height)*.5;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    [self drawInRect:tar];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}





+(UIImage *)gifImgF:(NSString *)path{
  return [self gifImg:[NSData dataWithContentsOfFile:path]];
}


+(UIImage *)gifImg:(NSData *)data{
    
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
    
}



+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
