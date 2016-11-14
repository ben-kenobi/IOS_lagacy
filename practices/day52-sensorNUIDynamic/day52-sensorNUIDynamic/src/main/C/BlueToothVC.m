
//
//  BlueToothVC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "BlueToothVC.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothVC ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong)CBCentralManager *cbm;
@property (nonatomic,strong)NSMutableArray<CBPeripheral *> *peripherals;
@end

@implementation BlueToothVC

-(NSMutableArray<CBPeripheral *> *)peripherals{
    if(!_peripherals){
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  1>>
    self.cbm = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    [_cbm scanForPeripheralsWithServices:nil options:nil];
    
}












#pragma --mark
#pragma --mark CBCentralManagerdelegate

//  2>>
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"%ld",central.state);
}

//  3>>
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    if(![self.peripherals containsObject:peripheral]){
        [self.peripherals addObject:peripheral];
    }
    
    // pop a chooser for user to choose peripheral
}

// trigged when user choose a peripheral
//  4>>
-(void)didSelectPeripheralAtIdx:(int)idx{
    [self.cbm connectPeripheral:self.peripherals[idx] options:nil];
}


// invoked when connect a peripheral
//  5>>
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    // discover all peripheral's service
    [peripheral discoverServices:nil];
    peripheral.delegate=self;
    
    
}



#pragma --mark
#pragma --mark CBPeripheraldelegate

//invoked when discover services of a peripheral
//  6>>
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    
    if(error) return ;
    
    for (CBService *cs in peripheral.services){
        
        //  assume "XXXXX" is the service's UUID we search
        if ([cs.UUID.UUIDString isEqualToString:@"XXXXX"]){
            // discover all characteristic  in this service
            [peripheral discoverCharacteristics:nil forService:cs];
        }
    }
}


//invoked when discover characteristics of a service
// 7>>
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error{
    
    if(error) return;
    
    for(CBCharacteristic * cha in service.characteristics){
        //  assume "CCCCCCCC" is the Characteristic's UUID we search
        if([cha.UUID.UUIDString isEqualToString:@"CCCCCCCC"]){
            
            // begin data interact
            [peripheral readValueForCharacteristic:cha];
            [peripheral writeValue:[@"your content" dataUsingEncoding:4] forCharacteristic:cha type:CBCharacteristicWriteWithResponse];
        }
        
    }
}











-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 8>>
    [self.cbm stopScan];
}

@end
