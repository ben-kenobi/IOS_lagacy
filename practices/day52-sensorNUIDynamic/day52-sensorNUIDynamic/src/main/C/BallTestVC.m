
//
//  BallTestVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "BallTestVC.h"
#import <CoreMotion/CoreMotion.h>

@interface BallTestVC ()
@property (nonatomic,strong)UIImageView *ball;
@property (nonatomic,strong)CMMotionManager *mm;
@property (nonatomic,assign)CGFloat xdelt;
@property (nonatomic,assign)CGFloat ydelt;
@end

@implementation BallTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ball=[[UIImageView alloc] initWithFrame:(CGRect){0,0,50,50}];
    self.ball.backgroundColor=[UIColor redColor];
    self.ball.layer.cornerRadius=25;
    [self.view addSubview:self.ball];

    self.mm = [[CMMotionManager alloc] init];
    if (self.mm.isGyroAvailable) {
        self.mm.gyroUpdateInterval=0.1;
        [self.mm startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
        }];
    }
    
    if (self.mm.isAccelerometerAvailable) {
        self.mm.accelerometerUpdateInterval=0.1;
        [self.mm startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            [self changeBall:accelerometerData.acceleration];
        }];
    }
    
}


-(void)changeBall:(CMAcceleration )ac{
    self.xdelt+=ac.x;
    self.ydelt+=ac.y;
    CGPoint p =  CGPointMake(self.ball.x+self.xdelt, self.ball.y-self.ydelt);
    if (p.x<0) {
        p.x=0;
        self.xdelt *= -0.8;
    }else if (p.x > self.view.w-self.ball.w){
        p.x=self.view.w-self.ball.w;
        self.xdelt *= -0.8;
    }
    
    if (p.y<0) {
        p.y=0;
        self.ydelt *= -0.8;
    }else if  (p.y > self.view.h-self.ball.h){
        p.y=self.view.h-self.ball.h;
        self.ydelt *= -0.8;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.ball.origin=p;
    });
    
}


@end
