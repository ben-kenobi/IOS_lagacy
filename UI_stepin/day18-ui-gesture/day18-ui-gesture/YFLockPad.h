//
//  YFLockPad.h
//  day18-ui-gesture
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFLockPad : UIView


-(void)setOnfinish:(BOOL (^)(NSString *))onfinish complete:(void (^)())comp;

@end
