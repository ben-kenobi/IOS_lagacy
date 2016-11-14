//
//  NSString+Ex.h
//  day26-thread-02
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ex)

-(instancetype)strByAppendToCachePath;
-(instancetype)strByAppendToDocPath;
-(instancetype)strByAppendToTempPath;
@end
