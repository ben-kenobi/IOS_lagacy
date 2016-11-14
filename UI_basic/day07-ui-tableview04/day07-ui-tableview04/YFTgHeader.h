//
//  YFTgHeader.h
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTgHeader : UIView
-(void)initUI:(id<UIScrollViewDelegate>)delegate;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndi;
@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (strong,nonatomic) NSTimer *timer;

-(void)startTImer;
@end
