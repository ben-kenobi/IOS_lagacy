//
//  UIImageView+WEB.h
//  day26-thread-02
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WEB)


@property (nonatomic,strong)NSString *adr;

-(void)asynDL:(NSString *)str def:(UIImage *)defimg;


    
@end
