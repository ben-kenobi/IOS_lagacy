//
//  ViewController.m
//  day02-ui-tomcat
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define ARYPATH @"Property List.plist"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)animate2:(id)sender {
    [self animateWithName:@"stomach_" from:0 to:33 andRepeat:1 andInterval:0.1];
}

- (IBAction)clickHead:(UIButton *)sender {
    [self animateWithName:@"angry_" from:0 to:25 andRepeat:1 andInterval:0.1];
}
-(void)animateWithName:(NSString *)prefix from:(NSInteger)from to:(NSInteger)to andRepeat:(NSInteger)count andInterval:(CGFloat)interval{
    if(self.imgV.isAnimating) return;
    
    NSMutableArray *ary = [NSMutableArray array];
    for(NSInteger i=from;i<=to;i++  )

        [ary addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%02ld.jpg",prefix,i] ofType:nil]]];
    self.imgV.animationRepeatCount=count;
    self.imgV.animationDuration=(to-from)*interval;
    self.imgV.animationImages=ary;
    [self.imgV startAnimating];
    [self.imgV performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imgV.animationDuration];
    NSLog(@"%@",[[NSBundle mainBundle] bundlePath]);
}

-(void)animateWithAry:(NSArray *)ary andRepeat:(NSInteger)count andInterval:(CGFloat)interval{
    if(self.imgV.isAnimating) return;
    NSMutableArray *imgary = [NSMutableArray array];
    for(int i=0;i<ary.count;i++  )
        [imgary addObject:[UIImage imageNamed:ary[i][@"img"]]];
    self.imgV.animationRepeatCount=count;
    self.imgV.animationDuration=ary.count*interval;
    self.imgV.animationImages=imgary;
    [self.imgV startAnimating];
    [self.imgV performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imgV.animationDuration ];
}


@end
