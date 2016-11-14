
//
//  UIImage+Extension.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIImage+Extension.h"


CGMutablePathRef shapePath(CGSize size,NSInteger count,NSInteger step,NSInteger multi){
    if(!count) return 0;
    
    CGFloat cx=size.width*.5,cy=size.height*.5,rad=MIN(size.width,size.height)*.5;
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef patharc=CGPathCreateMutable();
   
    CGFloat from=0,to=from,gap=M_PI*2/(CGFloat)count;
    CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
    CGPoint cur=CGPathGetCurrentPoint(patharc);
    CGPathMoveToPoint(path, 0, cur.x, cur.y);
    
    for(int i=0;i<step%(count+1);i++){
        if(!((multi*i)%count)){
            to=from+gap;
            CGPathAddArc(patharc, 0, cx, cy, rad, from , to, 0);
            cur= CGPathGetCurrentPoint(patharc);
            CGPathMoveToPoint(path, 0, cur.x, cur.y);
            from=to;
        }
        
        to=from+gap*multi;
        CGPathAddArc(patharc, 0, cx, cy, rad, from , to, 0);
        cur= CGPathGetCurrentPoint(patharc);
        CGPathAddLineToPoint(path, 0, cur.x, cur.y);
        from=to;
    }
    CGPathRelease(patharc);
    return path;
}




@implementation UIImage (Extension)


+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color angle:(NSInteger)angle multi:(NSInteger)multi drawtype:(int)type step:(NSInteger)step {
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    [color set];
    
    CGMutablePathRef path1=shapePath(size, angle, step, multi);
    
    CGContextAddPath(con, path1);
    
    CGPathRelease(path1);
    if(type==-1){
        CGContextClip(con);
    }else if(type==-2){
        CGContextEOClip(con);
    }else{
        CGContextDrawPath(con,type);
    }
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;

}
+(instancetype)shapeImgWithSize:(CGSize)size color:(UIColor *)color angle:(NSInteger)angle line:(NSInteger)line drawtype:(int)type anglestep:(NSInteger)astep linestep:(NSInteger)lstep{
   
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    [color set];
    
    CGMutablePathRef path1=shapePath(size, angle, astep, 1);
    CGMutablePathRef path2=shapePath(size, line, lstep, 2);
    CGContextAddPath(con, path1);
    CGContextAddPath(con, path2);
    CGPathRelease(path1);CGPathRelease(path2);
    if(type==-1){
        CGContextClip(con);
    }else if(type==-2){
        CGContextEOClip(con);
    }else{
        CGContextDrawPath(con,type);
    }
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
