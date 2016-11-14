//
//  EditController.h
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFContact;
@protocol EditDelegate <NSObject>

-(void)commitEdit;

@end

@interface EditController : UIViewController

@property (nonatomic,weak)id<EditDelegate> delegate;
@property (nonatomic,strong)YFContact *con;

@end
