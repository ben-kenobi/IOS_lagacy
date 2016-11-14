

//
//  StepCounterVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "StepCounterVC.h"
#import <CoreMotion/CoreMotion.h>
@interface StepCounterVC ()
@property (nonatomic,strong)CMStepCounter *sc;
@property (nonatomic,strong)CMPedometer *pedo;
@end

@implementation StepCounterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    
    
    // IOS7
    if ([CMStepCounter isStepCountingAvailable]) {
        self.sc=[[CMStepCounter alloc]init];
        [self.sc startStepCountingUpdatesToQueue:[[NSOperationQueue alloc]init] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
            NSLog(@"%ld",numberOfSteps);
        }];
    }
    
    
    // IOS8
    if([CMPedometer isStepCountingAvailable]){
        self.pedo = [[CMPedometer alloc] init];
        [self.pedo startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            NSLog(@"%@",pedometerData.numberOfSteps);
        }];
    }
}


@end
