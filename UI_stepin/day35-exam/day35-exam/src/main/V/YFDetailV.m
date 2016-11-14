//
//  YFDetailV.m
//  day35-exam
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDetailV.h"

@implementation YFDetailV


-(void)drawRect:(CGRect)rect{
    if(!self.dict) return;
    CGRect imgf={(self.w-120)*.5,40,120,120};
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetAllowsFontSmoothing(UIGraphicsGetCurrentContext(), YES);
    if(self.img){
        static int i=0;
        [self.img drawInRect:imgf blendMode:i%(kCGBlendModePlusLighter+1) alpha:1];
    }
    NSString *name=self.dict[@"name"];
    NSString *intro=self.dict[@"intro"];
    NSDictionary *nameatt=@{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    NSDictionary *introatt=@{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize namesize=[name boundingRectWithSize:(CGSize){self.w*.8,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:nameatt context:0].size;
    CGSize introsize=[intro boundingRectWithSize:(CGSize){self.w*.8,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:introatt context:0].size;
    CGRect namef={(self.w-namesize.width)*.5,CGRectGetMaxY(imgf)+25,namesize};
    [name drawWithRect:namef options:NSStringDrawingUsesLineFragmentOrigin attributes:nameatt context:0];
    
    [intro drawWithRect:(CGRect){(self.w-introsize.width)*.5,CGRectGetMaxY(namef)+50,introsize} options:NSStringDrawingUsesLineFragmentOrigin attributes:introatt context:0];
    
    
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    
    [self setNeedsDisplay];
    [IUtil get:iURL(_dict[@"icon"]) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            self.img=[UIImage imageWithData:data scale:iScreen.scale];
        }else{
            
        }
    }];
    
}

-(void)setImg:(UIImage *)img{
    _img=img;
    [self setNeedsDisplay];
}

@end
