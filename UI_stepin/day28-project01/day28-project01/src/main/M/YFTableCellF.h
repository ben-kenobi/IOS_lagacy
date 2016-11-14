//
//  YFTableCellF.h
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFTableCellF : NSObject

@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,assign)CGRect keyf;
@property (nonatomic,assign)CGRect valf;
@property(nonatomic,assign)CGFloat height;


+(instancetype)fWithDict:(NSDictionary *)dict;
@end
