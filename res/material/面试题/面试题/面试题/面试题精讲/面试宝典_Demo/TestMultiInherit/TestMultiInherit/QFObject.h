//
//  QFObject.h
//  TestMultiInherit
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>  
#import "QFProtocol.h"
/*
 （1）protected——这个指令后面的实例变量可被该类及任何子类中定义的方法直接访问。默认。
 
 （2）private——这个指令后面的实例变量可被定义在该类的方法直接访问，但是不能被子类中定义的方法直接访问。
 
 （3）public——这个指令后面的实例变量可被该类中定义的方法直接访问，也可被其他类或模块中定义的方法直接访问。
 
 （4）package——
 
 @public指令使得其他方法或函数可以通过使用指针运算符（->）访问实例变量。
 */

@interface QFObject : NSObject<QFProtocol>
{
    
@public
    int qfPublicValue_;
    
@protected
    NSString *qfProtectValue_;
    
@private
    NSString *qfPrivateValue_;
    
@package
    NSString *qfPackageValue_;
}

-(void)QFDescription;

@end
