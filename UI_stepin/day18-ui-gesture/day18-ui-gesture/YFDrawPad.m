//
//  YFDrawPad.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDrawPad.h"


void clearRect(CGContextRef con,CGRect rect){
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:.5] setFill];;
    CGContextFillRect(con, rect);
}
@interface YFPath :UIBezierPath
@property (nonatomic,strong)UIColor *linecolor;
@end


@interface YFDrawPad ()
@property (nonatomic,strong)NSMutableArray * paths;
@property (nonatomic,strong)NSMutableArray *undos;
@property (nonatomic,strong)NSMutableArray *eraseRects;

@end

@implementation YFDrawPad

-(void)drawRect:(CGRect)rect{
    [self.paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[NSValue class]]){
            CGContextClearRect(UIGraphicsGetCurrentContext(),[obj CGRectValue]);
//            clearRect(UIGraphicsGetCurrentContext(), [obj CGRectValue]);
        }else{
            [[obj linecolor] setStroke];
            [obj stroke];
        }
    }];
    
    
}

-(UIColor *)linecolor{
     return self.getColor?self.getColor():0;
}


-(void)undo{
    if(self.paths.lastObject)
        [self.undos addObject:self.paths.lastObject];
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

-(void)redo{
    if(self.undos.lastObject)
        [self.paths addObject:self.undos.lastObject];
    [self.undos removeLastObject];
    [self setNeedsDisplay];
}
-(void)clear{
    [self.undos addObjectsFromArray:self.paths];
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(NSMutableArray *)eraseRects{
    if(!_eraseRects){
        _eraseRects=[NSMutableArray array];
    }
    return _eraseRects;
}


-(NSMutableArray *)undos{
    if(!_undos){
        _undos=[NSMutableArray array];
    }
    return _undos;
}
-(NSMutableArray *)paths{
    
    if(!_paths){
        _paths=[NSMutableArray array];
    }
    return _paths;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint cur=[touch locationInView:touch.view];
    if(!self.es){
        YFPath *bpath=[[YFPath alloc ]init];
        [bpath moveToPoint:cur];
        [bpath setLineCapStyle:1];
        [bpath setLineJoinStyle:1];
        [bpath setLineWidth:self.getWid?self.getWid():1];
        [bpath setLinecolor:self.linecolor];
        [self.paths addObject:bpath];
        [self.undos removeAllObjects];
    }else{
        [self addtoErase:cur];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint cur=[touch locationInView:touch.view];
    if(!self.es){
        UIBezierPath *bpath=[self.paths lastObject];
        [bpath addLineToPoint:(CGPoint){cur.x,cur.y}];
        [self setNeedsDisplay];
    }else{
        [self addtoErase:cur];
    }
    
}

-(void)addtoErase:(CGPoint)cur{
    CGFloat wid=self.getWid();
    CGRect rect={cur.x-wid*.5,cur.y-wid*.5,wid,wid};
    [self.paths addObject:[NSValue valueWithCGRect:rect]];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end


@implementation YFPath


@end
