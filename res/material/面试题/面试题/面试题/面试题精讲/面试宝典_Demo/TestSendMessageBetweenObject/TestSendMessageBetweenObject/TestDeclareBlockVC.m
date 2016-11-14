//
//  TestDeclareBlockVC.m
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "TestDeclareBlockVC.h"

@interface TestDeclareBlockVC ()
 
@property(nonatomic,strong)IBOutlet UITextField *contentTF;

@end

@implementation TestDeclareBlockVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

-(id)initWithBlock:(CompleteBlock)back
{
    self = [self init];
    if(self)
    {
        callBack_ = back;
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
    callBack_(_contentTF.text);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
