//
//  QFObjectARC.h
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFObjectARC : NSObject

@property(assign,nonatomic)NSInteger       tag;
@property(strong,nonatomic)NSMutableString *mutableStr;

@end
