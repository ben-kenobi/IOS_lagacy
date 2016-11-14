//
//  YFView02.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFView02.h"
#import "UIColor+Extension.h"
#import "UIImage+Extension.h"
CGMutablePathRef shape2Path(CGSize size,NSInteger count,NSInteger step,int isline);

void template1(void (^block)(CGContextRef con,CGMutablePathRef path),int drawtype){
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    
    block(con,path);
    
    CGContextAddPath(con, path);
    CGPathRelease(path);
    if(drawtype==-1)
        CGContextClip(con);
    else if(drawtype==-2)
        CGContextEOClip(con);
    else
        CGContextDrawPath(con, drawtype);
    
}

NSString *docPathWith(NSString *name){
    NSString *str= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES) firstObject] stringByAppendingPathComponent:name];
    NSLog(@"%@",str);
    return str;
}


@interface YFView02 ()
{
    NSInteger num;
}

@end

@implementation YFView02

-(instancetype)initWithImg:(UIImage *)img{
    if(self=[super init]){
        self.img=img;
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self test];
    
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"subview1111111111111");
    return [super hitTest:point withEvent:event];
}

-(void)setImg:(UIImage *)img{
    _img=img;
    self.frame=(CGRect){self.frame.origin,img.size.width,img.size.height};

    [self setBackgroundColor:[UIColor orangeColor]];
    [self setNeedsDisplay];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    num++;
    
 NSLog(@"11111111000000");
    [self setNeedsDisplay];
    [super touchesBegan:touches withEvent:event];
//    CGSize size=self.layer.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *img2=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    CGFloat wid=40;
//    CGSize newsize={size.width+wid*2,size.height+wid*2};
//    UIGraphicsBeginImageContext(newsize);
//    [img2 drawAtPoint:(CGPoint){wid,wid}];
//    CGContextAddArc(UIGraphicsGetCurrentContext(), newsize.width*.5, newsize.height*.5, (newsize.width-wid)*.5, 0, 2*M_PI, 0);
//    [[UIColor redColor]setStroke];
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), wid);
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), 2);
//    img2=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(img2, 0, 0, 0);
}

-(CGMutablePathRef)starPathCenterPoint:(CGPoint)origin rad:(CGFloat)rad{
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef arcp=CGPathCreateMutable();
    CGFloat cx=origin.x,cy=origin.y;
    
    CGFloat fromAngle=-M_PI_2,toAngle=fromAngle;
    CGPathAddArc(arcp, 0, cx, cy, rad, fromAngle, toAngle, 0);
    CGPoint cur=CGPathGetCurrentPoint(arcp);
    CGPathMoveToPoint(path, 0, cur.x, cur.y);
    for(int i=0;i<=5;i++){
        toAngle=fromAngle+M_PI*.8;
        CGPathAddArc(arcp, 0, cx, cy, rad, fromAngle, toAngle, 0);
        cur=CGPathGetCurrentPoint(arcp);
        CGPathAddLineToPoint(path, 0, cur.x, cur.y);
        
        fromAngle=toAngle;
    }
    CFRelease(arcp);
    return path;
}

-(void)test{
    CGSize newsize=self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(newsize, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(con, newsize.width*.5, newsize.height*.5);
    CGContextRotateCTM(con, M_PI_4);
    CGContextTranslateCTM(con, newsize.width*-.5, newsize.height*-.5);
    
    
    [_img drawAtPoint:(CGPoint){0,0}];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [img drawAtPoint:(CGPoint){0,0}];
    
}

-(void)test19{
    CGSize newsize={200,200};
    int count=23;
    CGMutablePathRef path=shape2Path(newsize, count, num%(count+1), 0);
    
    UIGraphicsBeginImageContextWithOptions(newsize, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){50,100}];
}


CGMutablePathRef shape2Path(CGSize size,NSInteger count,NSInteger step,int isline){
    if(!count) return 0;
    
    CGFloat cx=size.width*.5,cy=size.height*.5,rad=MIN(size.width,size.height)*.5;
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef patharc=CGPathCreateMutable();
    int multi=isline?1:9;
    CGFloat from=0,to=from,gap=M_PI*2*multi/(CGFloat)count;
    CGPathAddArc(patharc, 0, cx, cy, rad, from, to, 0);
    CGPoint cur=CGPathGetCurrentPoint(patharc);
    CGPathMoveToPoint(path, 0, cur.x, cur.y);
    
    for(int i=0;i<step%(count+1);i++){
//        if(!isline&&count*.5==i){
//            to=from+gap*.5;
//            CGPathAddArc(patharc, 0, cx, cy, rad, from , to, 0);
//            cur= CGPathGetCurrentPoint(patharc);
//            CGPathMoveToPoint(path, 0, cur.x, cur.y);
//            from=to;
//        }
    
        to=from+gap;
        CGPathAddArc(patharc, 0, cx, cy, rad, from , to, 0);
        cur= CGPathGetCurrentPoint(patharc);
        CGPathAddLineToPoint(path, 0, cur.x, cur.y);
        from=to;
    }
    CGPathRelease(patharc);
    return path;
}


-(void)test18{
    
    int count1=arc4random()%15+3;
    int count2=arc4random()%15+3;
    
    [[UIColor grayColor ]set];
    CGContextAddRect(UIGraphicsGetCurrentContext(), CGContextGetClipBoundingBox(UIGraphicsGetCurrentContext()));
    CGContextDrawPath(UIGraphicsGetCurrentContext(), 0);
    
    UIImage *img=[UIImage shapeImgWithSize:(CGSize){150,200} color:[UIColor orangeColor] angle:count1 line:count2 drawtype:1 anglestep:count1 linestep:count2];
    [img drawAtPoint:(CGPoint){50,100}];
    
}

-(void)test17{
    CGSize newsize={150,150};
    CGFloat cx=newsize.width*.5,cy=newsize.height*.5,rad=newsize.width*.5;
    
    CGMutablePathRef path1=CGPathCreateMutable();
    CGMutablePathRef path1arc=CGPathCreateMutable();
    CGFloat count=7.0;
    CGFloat from1=0,to1=from1,gap=M_PI*2/count;
    CGPathAddArc(path1arc, 0, cx, cy, rad, from1, to1, 0);
    CGPoint cur1=CGPathGetCurrentPoint(path1arc);
    CGPathMoveToPoint(path1, 0, cur1.x, cur1.y);
    
    CGMutablePathRef path2=CGPathCreateMutable();
    CGMutablePathRef path2arc=CGPathCreateMutable();
    CGFloat from2=0,to2=from1,gap2=M_PI*4/count;
    CGPathAddArc(path2arc, 0, cx, cy, rad, from2, to2, 0);
    CGPoint cur2=CGPathGetCurrentPoint(path2arc);
    CGPathMoveToPoint(path2, 0, cur2.x, cur2.y);
    
    for(int i=0;i<(num%(int)(count+1));i++){
        to1=from1+gap;
        CGPathAddArc(path1arc, 0, cx, cy, rad, from1, to1, 0);
       cur1= CGPathGetCurrentPoint(path1arc);
        CGPathAddLineToPoint(path1, 0, cur1.x, cur1.y);
        from1=to1;
        
        
        if(i==count*.5){
            to2=from2+gap2*.5;
            CGPathAddArc(path2arc, 0, cx, cy, rad, from2, to2, 0);
            cur2=CGPathGetCurrentPoint(path2arc);
            CGPathMoveToPoint(path2, 0, cur2.x, cur2.y);
            from2=to2;
        }
        
        to2=from2+gap2;
        CGPathAddArc(path2arc, 0, cx, cy, rad, from2, to2, 0);
        cur2= CGPathGetCurrentPoint(path2arc);
        CGPathAddLineToPoint(path2, 0, cur2.x, cur2.y);
        from2=to2;
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newsize, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddPath(con, path1);
    CGContextAddPath(con, path2);
//    CGContextAddPath(con, path1arc);
    CGContextDrawPath(con,2);
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawInRect:(CGRect){50,200,newsize}];
}
-(void)test16{
    CGSize newsize={300,180};
    UIGraphicsBeginImageContextWithOptions(newsize, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    [[UIColor redColor] setFill];
    CGContextDrawPath(con, 0);
    
    [[UIColor colorWithRed:.78 green:.76 blue:.1 alpha:1] setFill];
    CGFloat rad=28;
    CGPoint center={18+rad,18+rad};
    CGMutablePathRef path=[self starPathCenterPoint:center rad:rad];
    CGContextAddPath(con,path);
    CFRelease(path);
    CGMutablePathRef arc=CGPathCreateMutable();
    
    CGFloat fromAngle=0,toAngle;
    
    for(int i=0;i<4;i++){
        toAngle=fromAngle+i*M_PI_2/3;
        CGPathAddArc(arc, 0, center.x, center.y, rad*2,fromAngle , toAngle, 0);
        path=[self starPathCenterPoint:CGPathGetCurrentPoint(arc) rad:14];
        CGContextAddPath(con,path);
        CFRelease(path);
      
    }
    
    CGContextDrawPath(con, 0);
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){10,200}];
}

-(void)test15{
    NSInteger hei=self.bounds.size.height,
    wid=self.bounds.size.width;
    int count=9;
    
    [[UIColor colorWithRed:.3 green:.3 blue:.3 alpha:1] setFill];
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddRect(con, self.bounds);
    CGContextDrawPath(con, 0);
    
    UIImage *img=[UIImage imageNamed:@"snow"];
    

    for(int i=0;i<count;i++){
        [img drawAtPoint:(CGPoint){arc4random()%wid,arc4random()%hei}];
    }
    
    
}

-(void)test14{
    CGFloat fringeW=40;
    CGSize newsize={self.bounds.size.width+fringeW*2,self.bounds.size.height+fringeW*2};
    CGFloat centerx=newsize.width*.5,centery=newsize.height*.5,
    outr=newsize.width*.5,innr=outr-fringeW,innr2=innr-4;
    
    
    CGMutablePathRef hexp=CGPathCreateMutable();
    CGMutablePathRef hexagonP=CGPathCreateMutable();
    CGMutablePathRef hexarc=CGPathCreateMutable();
    CGMutablePathRef hexagonArc=CGPathCreateMutable();
    
    
    CGFloat hexSa=-M_PI_2+num*M_PI*.1,hexEa=hexSa,hexaSa=hexSa,hexaEa=hexaSa;
    CGPathAddArc(hexarc, 0, centerx, centery, innr2, hexSa, hexEa, 0);
    CGPathAddArc(hexagonArc, 0, centerx, centery, innr2, hexaSa, hexaEa, 0);
    CGPoint hexCur=CGPathGetCurrentPoint(hexarc),
    hexaCur=CGPathGetCurrentPoint(hexagonArc);
    CGPathMoveToPoint(hexp,0, hexCur.x, hexCur.y);
    CGPathMoveToPoint(hexagonP,0, hexaCur.x, hexaCur.y);
    
    for(int i=0;i<=5;i++){
        if(i==3){
            hexEa=hexSa+M_PI/3;
            CGPathAddArc(hexarc, 0, centerx, centery, innr2, hexSa, hexEa, 0);
            hexCur=CGPathGetCurrentPoint(hexarc);
            CGPathMoveToPoint(hexp, 0, hexCur.x, hexCur.y);
            hexSa=hexEa;
        }
        
        hexEa=hexSa+M_PI/1.5;
        CGPathAddArc(hexarc, 0, centerx, centery, innr2, hexSa, hexEa, 0);
        hexCur=CGPathGetCurrentPoint(hexarc);
        CGPathAddLineToPoint(hexp, 0, hexCur.x, hexCur.y);
        hexSa=hexEa;
        
        hexaEa=hexaSa+M_PI/3.0;
        CGPathAddArc(hexagonArc, 0, centerx, centery, innr2, hexaSa, hexaEa, 0);
        hexaCur=CGPathGetCurrentPoint(hexagonArc);
        CGPathAddLineToPoint(hexagonP, 0, hexaCur.x, hexaCur.y);
        hexaSa=hexaEa;
    }
    
    
    
    
    UIGraphicsBeginImageContextWithOptions(newsize, 0, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddArc(con, centerx, centery,outr, 0, 2*M_PI, 0);
    CGContextClip(con);
    CGContextAddRect(con, (CGRect){0,0,newsize});
    [[UIColor blueColor] setFill];
    CGContextDrawPath(con, 0);
    
    CGContextAddArc(con, centerx, centery, outr, 0, 2*M_PI, 0);
    CGContextAddArc(con, centerx, centery, innr, 0, -2*M_PI, 1);
    [[UIColor redColor] setFill];
    CGContextDrawPath(con, 0);
    
    
    CGContextAddPath(con,hexagonP);
    CGContextAddPath(con,hexagonArc);
    CGContextAddPath(con, hexp);
    [[UIColor orangeColor] setFill];
    CGContextDrawPath(con, 1);
    
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGPathRelease(hexp);
    CGPathRelease(hexarc);
    CFRelease(hexagonP);
    CFRelease(hexagonArc);
    
    
    [img drawInRect:self.bounds];
}

-(void)test13{
    CGFloat wid=100;
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGAffineTransform tran=CGAffineTransformMakeRotation(M_PI_4);
    CGPathAddRect(path, &tran, (CGRect){200,0,wid,wid});
    CGPathAddArc(path, &tran, 250, 0, wid*.5, 0, 2*M_PI, 0);
     CGPathAddArc(path, &tran, 200, 50, wid*.5, 0, 2*M_PI, 0);
    

    
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
    
    
}

-(void)test12{
   
    CGFloat wid=40,innerrad=self.bounds.size.width*.5-5;
    CGSize imgsize={self.bounds.size.width+wid*2,self.bounds.size.height+wid*2};
    CGFloat outerrad=imgsize.width*.5;
    CGPoint center={imgsize.width*.5,imgsize.height*.5};
    
    UIGraphicsBeginImageContextWithOptions(imgsize, 0, 0);
    [[UIColor whiteColor] setFill] ;
   
    CGContextRef con= UIGraphicsGetCurrentContext();
    CGContextAddArc(con, center.x, center.y, outerrad, 0, 2*M_PI, 0);
    CGContextClip(con);
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    CGContextDrawPath(con, 0);
    [[UIColor redColor] setFill] ;
    
    CGMutablePathRef starP=CGPathCreateMutable();
    CGMutablePathRef pantagonP=CGPathCreateMutable();
    CGMutablePathRef starArc=CGPathCreateMutable();
    CGMutablePathRef pantagonArc=CGPathCreateMutable();
    CGMutablePathRef fringe=CGPathCreateMutable();
    
    CGPathAddArc(fringe, 0, center.x, center.y, outerrad,0 , 2*M_PI, 0);
    CGPathAddArc(fringe, 0, center.x, center.y, innerrad+5, 0, -2*M_PI, 1);
    CGContextAddPath(con, fringe);
    CGContextDrawPath(con,1);
    
    CGFloat starBangle=-M_PI_2,starEangle=starBangle,pantagonBanle=starBangle,pantagonEangle=starBangle;
    CGPoint starCurp,pantagonCurp;
    
    CGPathAddArc(starArc, 0, center.x, center.y, innerrad, starBangle,starEangle , 0);
    CGPathAddArc(pantagonArc, 0, center.x, center.y, innerrad, starBangle,starEangle , 0);
    starCurp=CGPathGetCurrentPoint(starArc);
    pantagonCurp=CGPathGetCurrentPoint(pantagonArc);
    CGPathMoveToPoint(starP, 0, starCurp.x, starCurp.y);
    CGPathMoveToPoint(pantagonP, 0, pantagonCurp.x, pantagonCurp.y);
    
    for(int i=0;i<(num%6);i++){
        starEangle=starBangle+M_PI*.8;
        CGPathAddArc(starArc, 0, center.x, center.y, innerrad, starBangle, starEangle, 0);
        starCurp=CGPathGetCurrentPoint(starArc);
        CGPathAddLineToPoint(starP, 0, starCurp.x, starCurp.y);
        starBangle=starEangle;
        
        
        pantagonEangle=pantagonBanle+M_PI*.4;
        CGPathAddArc(pantagonArc, 0, center.x, center.y, innerrad, pantagonBanle, pantagonEangle, 0);
        pantagonCurp=CGPathGetCurrentPoint(pantagonArc);
        
        CGPathAddLineToPoint(pantagonP,0, pantagonCurp.x, pantagonCurp.y);
        pantagonBanle=pantagonEangle;
    }
    
    [[UIColor blueColor]setFill];
    
    CGContextAddPath(con, starP);
    CGContextAddPath(con, pantagonArc);
//    CGContextAddPath(con, pantagonP);
    CGContextDrawPath(con,1);

    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
   
    
    [img drawInRect:self.bounds];

}


-(void)test11{
    [[UIColor blueColor] setFill];
    CGContextAddRect(UIGraphicsGetCurrentContext(), self.bounds);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), 0);
    
    CGFloat x,y;
    x=self.center.x,y=self.center.y;
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGMutablePathRef path2=CGPathCreateMutable();
    CGMutablePathRef path3=CGPathCreateMutable();
    CGMutablePathRef path4=CGPathCreateMutable();
    
    CGFloat starangle=-M_PI_2,endangle=starangle ,starangle2=-M_PI_2,endangle2=starangle;
    
    CGPathAddArc(path, 0, x, y, x, starangle, endangle, 0);
    CGPoint cur=CGPathGetCurrentPoint(path);
    CGPathMoveToPoint(path2, 0, cur.x,cur.y);
    
    
    CGPathAddArc(path3, 0, x, y, x, starangle2, endangle2, 0);
    CGPoint cur2=CGPathGetCurrentPoint(path3);
    CGPathMoveToPoint(path4, 0, cur2.x,cur2.y);
    
    for(int i=1;i<=5;i++){
        endangle=starangle+M_PI*.4;
        CGPathAddArc(path, 0, x, y, x, starangle, endangle, 0);
        cur=CGPathGetCurrentPoint(path);
        CGPathAddLineToPoint(path2, 0,cur.x, cur.y);
        starangle=endangle;
    }
    
    
    for(int i=1;i<=5;i++){
        endangle2=starangle2+M_PI*.8;
        CGPathAddArc(path3, 0, x, y, x, starangle2, endangle2, 0);
        cur2=CGPathGetCurrentPoint(path3);
        CGPathAddLineToPoint(path4, 0,cur2.x, cur2.y);
        starangle2=endangle2;
    }
    
    [[UIColor redColor]set];
    
    CGContextAddPath(con, path2);
    CGContextAddPath(con, path);
    CGContextAddPath(con, path4);
    CGContextDrawPath(con, 1);
}

-(void)test10{
    CGFloat x,y;
    x=self.center.x;y=self.center.y;
    CGContextRef con= UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGPoint points[6];
    
    for(int i=0;i<3;i++){
        CGPathAddArc(path, 0,x , y, 100, M_PI/6.0+M_PI/1.5*i, M_PI/6.0+M_PI/1.5*i, 0);
        points[i]=CGPathGetCurrentPoint(path);
    }
    for(int i=0;i<3;i++){
        CGPathAddArc(path, 0,x , y, 100, -(M_PI/6.0)+M_PI/1.5*i, -(M_PI/6.0)+M_PI/1.5*i, 0);
        points[i+3]=CGPathGetCurrentPoint(path);
    }
    
    
    CGContextMoveToPoint(con, points[2].x, points[2].y);
    [[UIColor orangeColor] set];
    for(int i=0;i<3;i++){
        
        CGContextAddLineToPoint(con, points[i].x, points[i].y);
    }
//    CGContextClosePath(con);
     CGContextMoveToPoint(con, points[5].x, points[5].y);
    for(int i=5;i>=3;i--){
        
        CGContextAddLineToPoint(con, points[i].x, points[i].y);
    }
//    CGContextClosePath(con);
    CGContextMoveToPoint(con, points[0].x, points[0].y);
    CGContextAddArc(con, x,y,  100, 0, 2*M_PI, 0);
    
    CGContextDrawPath(con, 1);
    
    
    
//    CGContextDrawPath(con, 2);
    
}

-(void)test9{
    CGFloat wid=100;
    
    UIGraphicsBeginImageContextWithOptions((CGSize){wid*1.5,wid*1.5}, 0, 0);
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGPathAddRect(path, 0, (CGRect){wid*.5,wid*.5,wid,wid});
        [[UIColor redColor] setFill];
        CGPathAddArc(path, 0, wid*.5, wid, wid*.5, -M_PI_2, M_PI_2, 1);
        CGPathAddArc(path, 0, wid, wid*.5, wid*.5, M_PI, 2*M_PI, 0);
        
    }, 0);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRotateCTM(UIGraphicsGetCurrentContext(), M_PI_4);
    [img drawAtPoint:(CGPoint){150,0}];
}

-(void)test8{
    CGFloat liw=10;
    CGSize consi={_img.size.width+liw*2,_img.size.height+liw*2};
    CGPoint center={consi.width*.5,consi.height*.5};
    UIGraphicsBeginImageContextWithOptions(consi, 0, 0);
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGPathAddArc(path, 0, center.x, center.y, center.x, 0, 2*M_PI, 0);
    }, -1) ;
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGContextSetLineWidth(con, liw);
        
        CGContextSetStrokeColor(con, (CGFloat []){0.5,0.5,0.5,0.5});
        CGPathAddArc(path, 0, center.x, center.y, center.x-liw*.5, 0, 2*M_PI, 0);
        [_img drawAtPoint:(CGPoint){liw,liw}];
    }, 2);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){0,0}];
    UIImageWriteToSavedPhotosAlbum(img, 0, 0, 0);
    
    
}

-(void)test7{
    
    UIGraphicsBeginImageContextWithOptions(_img.size, 0, 0);
    template1(^(CGContextRef con, CGMutablePathRef path) {
       [_img drawAtPoint:(CGPoint){0,0}];
       UIImage *img= [UIImage imageNamed:@"logo"];
        [img drawInRect:(CGRect){20,10,img.size} blendMode:num%(kCGBlendModePlusLighter+1) alpha:.5];
        NSDateFormatter *fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        NSString *dat=[fm stringFromDate:[NSDate date]];
        NSShadow *shad=[[NSShadow alloc] init];
        shad.shadowBlurRadius=3;
        shad.shadowColor=[UIColor blackColor];
        shad.shadowOffset=(CGSize){2,2};
        [dat drawAtPoint:(CGPoint){_img.size.width*.5,_img.size.height*.8}
          withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                           NSForegroundColorAttributeName:[UIColor whiteColor],
                           NSBackgroundColorAttributeName:[UIColor clearColor],
                           NSShadowAttributeName:shad
                            }];
    }, 0);
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){0,0}];
    UIImageWriteToSavedPhotosAlbum(img, 0, 0, 0);
    [UIImagePNGRepresentation(img) writeToFile:docPathWith(@"ww.png") atomically:YES];
    
}


-(void)test6{
    CGFloat linewid=10;
    CGSize consize={_img.size.width+linewid*2,_img.size.height+linewid*2};
    UIGraphicsBeginImageContextWithOptions(consize, 0, 0);
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGContextAddEllipseInRect(con,(CGRect){0,0,consize});
    }, -1);
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGContextSetLineWidth(con, linewid);
        CGContextAddEllipseInRect(con, (CGRect){linewid*.5,linewid*.5,consize.width-linewid,consize.height-linewid});
        [_img drawAtPoint:(CGPoint){linewid,linewid}];
    }, 2);
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){0,0}];
    
    UIImageWriteToSavedPhotosAlbum(img, 0, 0, 0);
        
  
}

-(void)test5{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, 0, 0) ;
    
    
    template1(^(CGContextRef con, CGMutablePathRef path) {
        CGContextSetLineWidth(con, 5);
        CGPathAddArc(path, 0, self.center.x, self.center.y, MIN(self.center.x,self.center.y)-4, 0, 2*M_PI, 0);
    }, -1);
    
    
    [_img drawAtPoint:(CGPoint){0,0}];
    UIImage *img= UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext();
    [img drawAtPoint:(CGPoint){0,0}];
    
  
    NSData *data=UIImagePNGRepresentation(img);
    [data writeToFile:docPathWith(@"test02.png") atomically:YES];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), @"eqweqwe");
   
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"%@",contextInfo);
}

-(void)test4{
   template1(^(CGContextRef con, CGMutablePathRef path) {
       CGContextSetLineWidth(con, 10);
       CGPathAddArc(path, 0, self.center.x, self.center.y-30, MIN(self.center.x,self.center.y), 0, -M_PI*2, 1);

       CGPathAddArc(path, 0, self.center.x, self.center.y+30, MIN(self.center.x,self.center.y), 0, -M_PI*2, 1);
   }, -1);
    

    
    [self.img drawInRect:self.bounds blendMode:0 alpha:.5];
    
}
-(void)test3{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    
    NSString *str=@"qeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqwqeqweqeq\ne\nqwqeqweqeqeqwqeqweqeqeqwqeqweqeqeqw";
//    [str drawAtPoint:self.bounds.origin withAttributes:nil];
    NSShadow *sha=[[NSShadow alloc] init];
    [sha setShadowBlurRadius:3];
    [sha setShadowColor:[UIColor blueColor]];
    [sha setShadowOffset:(CGSize){2,2}];
    
    [str drawInRect:self.bounds withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],NSBackgroundColorAttributeName:[UIColor grayColor],NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 ,NSShadowAttributeName:sha}];
    
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
    CFRelease(path);
   
}


-(void)test2{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRect(path, 0, (CGRect){100,100,100,20});
    CGContextAddPath(con, path);
    CGContextDrawPath(con, 2);
    CGPathRelease(path);
    
}
-(void)test1{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextSaveGState(con);
    CGContextSetLineWidth(con, 10);
    CGContextMoveToPoint(con, self.center.x, self.center.y);
    CGContextAddArc(con, self.center.x, self.center.y, 100, 0, 1.5*M_PI, NO);
    CGContextDrawPath(con, 2);
    CGContextSaveGState(con);
    CGContextRestoreGState(con);
    CGContextMoveToPoint(con, 200, 100);
    CGContextAddLineToPoint(con, 0, 0);
    CGContextDrawPath(con, 2);
    CGContextRestoreGState(con);
    CGContextMoveToPoint(con, 0, 0);
    CGContextAddQuadCurveToPoint(con, 100, 200, 100, 100);
    
    CGContextDrawPath(con, 2);
}
@end
