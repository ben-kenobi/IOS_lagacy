//
//  AddViewController.h
//  day13-ui-test
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCDelegate <NSObject>

-(void)addOrUpdateInfo:(NSDictionary *)info idx:(NSIndexPath *)idx;

@end

@interface AddViewController : UIViewController
@property (nonatomic,strong)NSDictionary *info;
@property (nonatomic,strong)NSIndexPath *idx;
@property (nonatomic,weak) id<AddCDelegate> delegate;
@end
