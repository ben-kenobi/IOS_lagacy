
//
//  ShakeVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "ShakeVC.h"
#import <CoreMotion/CoreMotion.h>
@interface ShakeVC ()
@property (nonatomic,strong)CMMotionManager *mm;
@end

@implementation ShakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor orangeColor];
    
    self.mm = [[CMMotionManager alloc] init];
    
    if (self.mm.isAccelerometerAvailable) {
        self.mm.accelerometerUpdateInterval=0.1;
        [self.mm startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
        }];
    }
}


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"shake   begin");
}
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"shake   cancelled");

}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"shake   end");

}


@end
