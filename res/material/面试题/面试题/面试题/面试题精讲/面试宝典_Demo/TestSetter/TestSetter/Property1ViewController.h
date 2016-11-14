//
//  Property1ViewController.h
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Property1ViewController : UIViewController
{
    NSInteger Number1;
    NSInteger Number2;
    
    NSNumber  *Number3;
}

- (void) setNumber1:(NSInteger) Num;
- (void) setNumber2:(NSInteger) Num;
- (NSInteger) Number1;
- (NSInteger) Number2;

-(void)setNumber3:(NSNumber *)number;
-(NSNumber *)Number3;

@end
