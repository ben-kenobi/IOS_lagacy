


//
//  LeanCloudVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "LeanCloudVC.h"
#import <AVOSCloud/AVOSCloud.h>


@interface LeanCloudVC ()

@end

@implementation LeanCloudVC

-(void)viewDidLoad{
    [super viewDidLoad];

    [self addVC:@"FoundVC" title:@"Found" img:img(@"found")];
    [self addVC:@"LostVC" title:@"Found" img:img(@"lost")];
    
}

-(void)addVC:(NSString *)vcname title:(NSString *)title img:(UIImage *)img{
    UIViewController *vc=[[NSClassFromString(vcname) alloc] init];
    vc.title=title;
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:iBFont(15)} forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:iBFont(15)}  forState:UIControlStateSelected];
    [vc.tabBarItem setImage:img];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
}


-(instancetype)init{
    if(self = [super init]){
        [UITabBar appearance].barStyle=0;
        
        [UINavigationBar appearance].barStyle = 0;
        
        [UITabBar appearance].tintColor = [UIColor orangeColor];
        [UINavigationBar appearance].tintColor = [UIColor orangeColor];
        [UITabBar appearance].translucent=false;
        [UINavigationBar appearance].translucent=false;
    }
    return self;
}

+ (void)initialize
{
    if (self == [LeanCloudVC class]) {
//            [AVOSCloud setApplicationId:@"g1iaalmunrpoxqdgo7wts2du2gp64pgebfez7og2eo97bjrq"
//                              clientKey:@"sjtuyo0bmgbdzr6rje0jqw4a0kfoh0836cwelzqrspm7jo34"];
    }
}

@end
