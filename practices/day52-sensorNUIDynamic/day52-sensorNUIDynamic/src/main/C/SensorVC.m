

//
//  SensorVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "SensorVC.h"
#import <CoreMotion/CoreMotion.h>
@interface SensorVC ()<UIAccelerometerDelegate>

@property (nonatomic,strong)CMMotionManager *mm;

@end

@implementation SensorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor randColor];
    // proximityMonitor
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [iNotiCenter addObserver:self selector:@selector(distanceChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    
    // accelerator ios4
    UIAccelerometer *acm = [UIAccelerometer sharedAccelerometer];
    acm.delegate=self;
    acm.updateInterval=1;
    
    // accelerator  after ios4   (push)
//    self.mm = [[CMMotionManager alloc] init];
//    if (self.mm.isAccelerometerAvailable) {
//        self.mm.accelerometerUpdateInterval=1;
//        [self.mm startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
//            if (error) {
//                return ;
//            }
//            NSLog(@"%f--%f--%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
//        }];
//    }
    
    
    // accelerator  after ios4   (pull)
    self.mm = [[CMMotionManager alloc] init];
    if (self.mm.isAccelerometerAvailable) {
        [self.mm startDeviceMotionUpdates];
    }
    
    
    
    //gyro
    if(self.mm.isGyroAvailable){
        self.mm.gyroUpdateInterval=1;

        [self.mm startGyroUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSLog(@"%f--%f--%f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
        }];
    }
    
    
    //magneto
    if(self.mm.isMagnetometerActive){
        self.mm.magnetometerUpdateInterval =1;
       [self.mm startMagnetometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            NSLog(@"%f--%f--%f",magnetometerData.magneticField.x,magnetometerData.magneticField.y,magnetometerData.magneticField.z);
       }];
    }
    
    
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CMAcceleration ac=  self.mm.accelerometerData.acceleration;
    NSLog(@"%f--%f--%f",ac.x,ac.y,ac.z);
    
    
}





#pragma  --mark
#pragma --mark delegate
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    NSLog(@"%f---%f----%f", acceleration.x,acceleration.y,acceleration.z);
}







-(void)distanceChange:(id)sender{
    iLog(@"%@",sender);
    if ([UIDevice currentDevice].proximityState) {
        // close to sth
    }else{
        // away from sth
    }
}
@end
