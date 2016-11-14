//
//  AddController.h
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFContact;
@protocol AddProtocol <NSObject>
-(void)addContact:(YFContact *)contact;
@end



@interface AddController : UIViewController
@property (nonatomic,weak) id<AddProtocol>delegate;
@end
