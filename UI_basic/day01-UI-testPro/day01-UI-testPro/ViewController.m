//
//  ViewController.m
//  day01-UI-testPro
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    @public
    int counter,lineval;
}
@property (weak, nonatomic) IBOutlet UILabel *counter;
@property (weak, nonatomic) IBOutlet UIProgressView *meter;

@property (weak, nonatomic) IBOutlet UITextField *txt;

- (IBAction)changeNum2:(UISlider *)sender;

- (IBAction)changeNum:(UIStepper *)sender;
-(void)updateLabel;
-(void)updateline;
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



- (IBAction)changeNum2:(UISlider *)sender {
    lineval=sender.value;
    [self updateline];
}

- (IBAction)changeNum:(UIStepper *)sender {
    counter=sender.value;
    [self updateLabel];
    
    
}

-(void)updateLabel{
    self.counter.text=[NSString stringWithFormat:@"%d",counter];
}
-(void)updateline{
    self.meter.progress = lineval;
    self.txt.text=[NSString stringWithFormat:@"%d",lineval ];
}
@end
