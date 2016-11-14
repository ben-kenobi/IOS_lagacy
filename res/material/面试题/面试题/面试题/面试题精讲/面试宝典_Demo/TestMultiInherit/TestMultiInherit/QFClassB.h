//
//  QFClassB.h
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "QFProtocol.h"

@interface QFClassB : NSObject <QFProtocol>
- (void)methodB;
@end


