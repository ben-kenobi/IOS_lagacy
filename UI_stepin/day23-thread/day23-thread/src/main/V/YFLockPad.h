//
//  YFLockPad.h
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFLockPad : UIView


-(void)setOnLogin:(BOOL (^)(NSString *pwd))login comp:(void (^)())comp;
@end
