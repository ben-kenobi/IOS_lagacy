//
//  YFDipatcher.h
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDipatcher : NSObject

@property (nonatomic,strong)NSMutableDictionary *imgs;
@property (nonatomic,strong)NSMutableDictionary *opers;
@property (nonatomic,strong)UIImage *defimg;
@property (nonatomic,strong)NSOperationQueue *que;


-(UIImage *)asynDLImg:(NSString *)key onComp:(void (^)(UIImage *img))onComp;
+(instancetype)share;
-(void)cancelOper:(NSString *)key;
@end
