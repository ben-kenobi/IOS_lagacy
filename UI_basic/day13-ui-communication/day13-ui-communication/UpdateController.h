//
//  UpdateController.h
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFContact;

@protocol UpdateDelegate <NSObject>

-(void)updateList;

@end
@interface UpdateController : UIViewController

@property (nonatomic,strong)YFContact *cont;
@property (nonatomic,weak)id<UpdateDelegate> delegate;
@end
