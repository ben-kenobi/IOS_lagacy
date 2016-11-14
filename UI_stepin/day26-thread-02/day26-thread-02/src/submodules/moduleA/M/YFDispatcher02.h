//
//  YFDispatcher02.h
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDispatcher02 : NSObject<NSCacheDelegate>

@property (nonatomic,strong)NSCache *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;

-(void)asynDLImg:(NSString *)key onComp:(void (^)(UIImage *img))onComp def:(UIImage *)defimg;
-(void)cancelOper:(NSString *)key;
+(instancetype)share;
@end
