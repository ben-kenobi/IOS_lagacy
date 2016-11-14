//
//  YFTv.m
//  day28-project01
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTv.h"

@implementation YFTv


- (void)drawRect:(CGRect)rect {
    if(self.show&&self.text.length==0)
        [self.ph drawAtPoint:(CGPoint){5,5} withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.show=NO;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.show=YES;
}
-(void)setShow:(BOOL)show{
    _show=show;
    [self setNeedsDisplay];
}

-(instancetype)init{
    if(self=[super init]){
        _show=YES;
        self.delegate=self;
    }
    return self;
}
@end
