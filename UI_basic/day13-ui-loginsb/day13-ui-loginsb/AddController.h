//
//  AddController.h
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFContact;
@protocol AddDelegate <NSObject>
-(void)addContact:(YFContact *)cont;
@end

@interface AddController : UIViewController

@property (nonatomic,weak)id<AddDelegate>delegate;

@end
