//
//  TestDeclareDelegateVC.h
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-27.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

/**
 *  //////////////关键 三步//////////////
 *
 *  @protocol 声明delegate，可以独立为单个的 .h文件
 *
 *  @property 设置delegate，确定消息回传的接受者
 *
 *  [_delegate completeTask:obj]; 告诉消息接受者 这边任务已完成
 */


#import <UIKit/UIKit.h>

@protocol TestDeclareDelegateVCDelegate <NSObject>


-(void)completeTask:(id)obj;

@end

@interface TestDeclareDelegateVC : UIViewController

@property(nonatomic,strong)NSString *content;
@property(weak)id<TestDeclareDelegateVCDelegate>delegate;

@end
