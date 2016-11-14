//
//  QFClassA+ClassBInheritance.h
//  TestMultiInherit
//
//  Created by qianfeng on 14-6-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFClassA.h"
@class QFClassB;
@interface QFClassA (ClassBInheritance)
@property (nonatomic,retain) QFClassB *classBInstance;
@end
