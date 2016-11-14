//
//  AFNTestVC.m
//  day27-network
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AFNTestVC.h"
#import "AFNetworking.h"
#import "IUtil.h"

@interface AFNTestVC ()
@property (nonatomic,weak)UIButton  *v;

@end

@implementation AFNTestVC


-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *v=[[UIButton alloc] initWithFrame:(CGRect){90,90,100,100}];
    [v setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:v];
    self.v=v;
    [v setTitle:@"123123123" forState:UIControlStateNormal];
    [v setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    AFNetworkReachabilityManager *nm=[AFNetworkReachabilityManager sharedManager];
//    [nm setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"%ld",status);
//    }];
//    [nm startMonitoring];
    
    
    
    
    
    //>>>1 session get
    AFHTTPSessionManager *man= [AFHTTPSessionManager manager];
    [man.securityPolicy setAllowInvalidCertificates:YES];
    [man GET:@"http://localhost/login/login.php" parameters:@{@"username":@"111",@"password":@"111"} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"get>>>>%@",responseObject);
        NSLog(@"get>>>>>%@",[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0]);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    
    //>>>>2  session post
    
    [man POST:@"http://localhost/login/login.php"  parameters:@{@"username":@"111",@"password":@"111"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"POST>>>>%@",responseObject);
        NSLog(@"POST>>>>>%@",[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    //>>>>3  session post upload
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [man POST:@"http://localhost/upload/upload-m.php"  parameters:@{@"username":@"111",@"password":@"111"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSString *f1=@"/Users/apple/Desktop/123.png";
            NSString *f2=@"/Users/apple/Desktop/1111.png";
            NSString *f3=@"/Users/apple/Desktop/1111.png";
            NSURLResponse *resp1=[IUtil synResponseByURL:iURL(([NSString  stringWithFormat:@"file://%@",f1]))];
            NSURLResponse *resp2=[IUtil synResponseByURL:iURL(([NSString  stringWithFormat:@"file://%@",f2]))];
            
            [formData appendPartWithFileData:iData4F(f1) name:@"userfile[]" fileName:@"123" mimeType:resp1.MIMEType];
            
            [formData appendPartWithFileURL:iURL(([NSString  stringWithFormat:@"file://%@",f2])) name:@"userfile[]" fileName:@"222" mimeType:resp2.MIMEType error:0];
            
            [formData appendPartWithFileURL:iURL(([NSString  stringWithFormat:@"file://%@",f3])) name:@"userfile[]" fileName:@"333" mimeType:@"application/octet-stream" error:0];
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"POST UP>>>>%@",responseObject);
            NSLog(@"POST UP>>>>>%@",[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0]);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    });
    
    
    
    //>>>>4  connection get
    [[AFHTTPRequestOperationManager manager]GET:@"http://localhost/login/login.php" parameters:@{@"username":@"111",@"password":@"111"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"connection --------%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

//    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
//
//    [man GET:@"http://localhost/login/login.php" parameters:@{@"username":@"111",@"password":@"111"} success:^(NSURLSessionDataTask *task, id responseObject) {
//       
//        NSLog(@"%@",responseObject);
//        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:4]);
//        
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error){
//        NSLog(@"%@",error);
//    }];
    
}

@end
