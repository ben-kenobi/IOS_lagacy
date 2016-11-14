//
//  IWNewFeatureViewController.h
//  天天微博
//
//  Created by 汪刚 on 14-6-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutBaoDaoRadio : UIViewController



@property (nonatomic, retain) UIImage* flakeImage;

- (void)onTimer;
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
@end
