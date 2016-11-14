//
//  YFLoginVC.m
//  day39-project01
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFGuideVC.h"

@interface YFGuideVC ()

@end

@implementation YFGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.contentSize=(CGSize){3*self.view.w,0};
    sv.pagingEnabled=YES;
    sv.showsHorizontalScrollIndicator=NO;
    sv.bounces=NO;
    [self.view addSubview:sv];
    
    for(int i=0;i<3;i++){
        UIImageView *iv=[[UIImageView alloc]initWithFrame:(CGRect){i*self.view.w,0,self.view.size}];
       iv.image= img(iFormatStr(@"guide_%d",i));
        [sv addSubview:iv];
        if(i==2){
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMain)];
            [iv setUserInteractionEnabled:YES];
            [iv addGestureRecognizer:tap];
        }
    }
    
}
-(void)toMain{
    [iNotiCenter postNotificationName:GUIDENOTI object:0];
}


@end
