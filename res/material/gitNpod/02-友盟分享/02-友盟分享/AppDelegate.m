//
//  AppDelegate.m
//  02-友盟分享
//
//  Created by itheima on 15/11/19.
//  Copyright © 2015年 itheima. All rights reserved.
// 564d314de0f55af2e700b46f

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //进行分享、授权操作需要在第三方平台创建应用并提交审核，友盟默认提供了大多数平台的测试账号，但如果需要将分享、授权来源、分享到QQ、Qzone的icon更改为自己APP的应用，就需要自己申请第三方账号。
    
    //如果想要自己的程序分享时, 底部显示自己的程序(点击可以跳转自己的官网).
    //1. 注册各个平台, 创建应用, 并提交审核.
    //2. 审核通过之后, 将需要的信息(APPKEY , APPID), 配置到友盟后台
    //3. 点击自己所创建的程序, 找到左边 社会化分享 , 再次点击 设置, 最后填入对应的值即可.
    
    
    // 初始化友盟分享平台 / 鉴权过程
    [UMSocialData setAppKey:@"564d314de0f55af2e700b46f"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    return YES;
}

// 此方法用于第三方程序授权成功后的回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

@end
