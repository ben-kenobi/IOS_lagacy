//
//  TestDeclareNotificationVC.m
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "TestDeclareNotificationVC.h"

@interface TestDeclareNotificationVC ()
{
    
}


@property(nonatomic,strong)IBOutlet UITextField *contentTF;

@end

@implementation TestDeclareNotificationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete:)];
    
    
    _contentTF.text = self.content;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)complete:(id)sender
{
#warning [NSNotificationCenter defaultCenter] 可以使用 object 和 userinfo 传递数据
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestDeclareNotificationVCComplete" object:_contentTF.text userInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
