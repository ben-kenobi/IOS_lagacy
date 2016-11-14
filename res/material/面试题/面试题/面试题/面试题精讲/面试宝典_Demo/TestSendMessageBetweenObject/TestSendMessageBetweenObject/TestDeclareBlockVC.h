//
//  TestDeclareBlockVC.h
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//
/**
 *  //////////////关键 三步//////////////
 *
 *  @typedef C Block  声明 block 方法，可以独立为单个的 .h文件
 *
 *  CompleteBlock callBack_ 保存回调Block的实现的块引用，确定消息回传的处理块
 *
 *  callBack_(obj);     回到消息处理块，
 */


#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(id obj);


@interface TestDeclareBlockVC : UIViewController
{
    @private
        CompleteBlock callBack_;
}

@property(nonatomic,strong)NSString *content;

-(id)initWithBlock:(CompleteBlock)back;

@end

