//
//  YFLockV2.h
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFLockV2 : UIView


@property (nonatomic,copy)BOOL (^onLogin)(NSString *);
@property (nonatomic,copy)void (^comp)();
-(void)setOnLogin:(BOOL (^)(NSString *))onLogin comp:(void (^)())comp;
@end
