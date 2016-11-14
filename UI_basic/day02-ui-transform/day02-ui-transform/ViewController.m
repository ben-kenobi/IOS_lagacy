//
//  ViewController.m
//  day02-ui-transform
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)transform:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    [UIView animateWithDuration:.5 animations:^{
        
        if([title isEqualToString:@"move"]){
            _redView.transform=CGAffineTransformTranslate(_redView.transform, 20, 0);
        }else if([title isEqualToString:@"rotate"]){
            _redView.transform=CGAffineTransformRotate(_redView.transform, M_PI_4);
        }else if([title isEqualToString:@"scale"]){
            _redView.transform=CGAffineTransformScale(_redView.transform, -.8, 1.3);
        }else if([title isEqualToString:@"reset"]){
            _redView.transform=CGAffineTransformIdentity;
        }

    }];
    
}

@end
