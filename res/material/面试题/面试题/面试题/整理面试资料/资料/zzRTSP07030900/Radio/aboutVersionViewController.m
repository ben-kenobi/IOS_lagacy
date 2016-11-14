//
//  aboutVersionViewController.m
//  zzRTSP
//
//  Created by 汪刚 on 07-9-19.
//  Copyright (c) 2007年 YunFeng. All rights reserved.
//

#import "aboutVersionViewController.h"

@interface aboutVersionViewController ()

@end

@implementation aboutVersionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutVersion"]];
    if (FourInch) {
        imageView.frame = CGRectMake(0, 0, 320, 568);

    }else
    {
        imageView.frame = CGRectMake(0, 0, 320, 480);

    }
    
       [self.view addSubview:imageView];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@" touchesBegan  == \n"   );
}




@end
