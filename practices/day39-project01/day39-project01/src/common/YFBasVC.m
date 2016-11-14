//
//  YFBasVC.m
//  day39-project01
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFBasVC.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"

@interface YFBasVC ()
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation YFBasVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)dismLoadV{
    if(self.hud){
        [_hud removeFromSuperview];
        [_hud hide:YES];
        _hud=0;
    }
}
-(void)showLoadVWithMes:(NSString *)mes{
    if(!mes.length){
        self.hud=[[MBProgressHUD alloc] initWithView:self.view];
        [self.hud show:YES];
        [self.view addSubview:self.hud];
    }
}
-(void)showToast:(NSString *)mes{
    [self.view makeToast:mes];
}




@end
