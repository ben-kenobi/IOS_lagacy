//
//  YFOper.h
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFOper : NSOperation

@property (nonatomic,copy)void(^onComp)(UIImage *img);
@property(nonatomic,copy)NSString *adr;

+(instancetype)operWithAdr:(NSString *)adr onComp:(void (^)(UIImage *img))onComp;
@end
