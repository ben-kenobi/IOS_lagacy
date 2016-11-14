//
//  UIImage+Ex.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIImage+Ex.h"

CGMutablePathRef shapePath(CGSize size,NSInteger count,NSInteger step,NSInteger multi){
    if(!count) return 0;
    CGFloat cx=size.width*.5,cy=size.height*.5,
    rad=MIN(cx,cy)*.9;
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef patharc=CGPathCreateMutable();
    
    CGFloat from=0,to=from,gap=2*M_PI/count;
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
   CGMutablePathRef path= shapePath(size, count, step, multi);
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



@end
