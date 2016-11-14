
//
//  YFSocialVC.m
//  day38-shareNGit
//
//  Created by apple on 15/11/25.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFSocialVC.h"
#import <Social/Social.h>
@interface YFSocialVC ()

@end

@implementation YFSocialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo ]){
        NSLog(@"not available");
        return ;
    }
    
    SLComposeViewController *vc=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [vc setInitialText:@"123"];
    [vc  addImage:img(@"")];
    [vc addURL:iURL(@"https://www.baidu.com")];
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"over");
    }];
}

@end
