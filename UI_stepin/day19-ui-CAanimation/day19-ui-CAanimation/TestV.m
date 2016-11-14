//
//  TestV.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "TestV.h"

@implementation TestV

-(void)trans:(id)sender{
    self.transform=CGAffineTransformScale(self.transform, 1.002, 1.002);
     NSLog(@"%@",NSStringFromCGRect(self.frame));
}
-(void)initState{
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(trans:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(instancetype)init{
    if(self=[super init]){
        [self initState];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.frame));
}

@end
