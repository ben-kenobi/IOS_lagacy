
//
//  YFShareVC.m
//  day38-shareNGit
//
//  Created by apple on 15/11/19.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFShareVC.h"
#import "UMSocial.h"

@interface YFShareVC ()<UMSocialUIDelegate>

@end

@implementation YFShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor randomColor]];
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self thirdlogin];
   
}


-(void)getUserInfo{
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"sinaUserInfo: %@",response.data);
    }];
}
-(void)thirdlogin{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

-(void)shareto{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:0 shareText:@"sharetext" shareImage:0 shareToSnsNames:@[UMShareToSina] delegate:self];
}


@end
