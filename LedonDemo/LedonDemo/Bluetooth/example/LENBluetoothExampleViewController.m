//
//  LENBluetoothExampleViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/7.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENBluetoothExampleViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define kServerUUID @"E8EC18F9-85EC-11D1-8803-046DFF82EF05"
// AA01C905-B324-D1EC-EC95-0A1A980181D3 耳机
// 620EC112-5013-27EE-8B36-D8A067A6E669 手机
// E8EC18F9-85EC-11D1-8803-046DFF82EF05 电脑
@interface LENBluetoothExampleViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *centeralManager;

@property (nonatomic, strong) CBPeripheral *peripheral; // 外设设备

@end

@implementation LENBluetoothExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_centeralManager) {
        [self.centeralManager stopScan]; // 停止扫描
        if (_peripheral && _peripheral.state == CBPeripheralStateConnecting) {
            [self.centeralManager cancelPeripheralConnection:self.peripheral]; // 停止连接
        }
    }
}

- (void)setUpUI{
    self.title = @"蓝牙example";
    NSDictionary *options = @{
                              CBCentralManagerOptionShowPowerAlertKey: [NSNumber numberWithBool:YES], // 在蓝牙关闭时提醒用户
                              };
    self.centeralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
}

# pragma mark -- 检查蓝牙是否打开 并扫描
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if(central.state == CBManagerStatePoweredOn){
        NSLog(@"蓝牙设备开着 开始扫描");
        NSDictionary *options = @{
                                  CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO], // 搜索不重名蓝牙
                                  CBConnectPeripheralOptionNotifyOnConnectionKey: [NSNumber numberWithBool:YES],
                                  CBConnectPeripheralOptionNotifyOnDisconnectionKey: [NSNumber numberWithBool:YES],
                                  CBConnectPeripheralOptionNotifyOnNotificationKey: [NSNumber numberWithBool:YES],
                                  };
        CBUUID *uuid = [CBUUID UUIDWithString:kServerUUID];;
        NSArray<CBUUID *> *uuids = @[uuid];
        [self.centeralManager scanForPeripheralsWithServices:nil options:nil];
    }
    else if (central.state == CBManagerStatePoweredOff){
        NSLog(@"蓝牙设备关着");
    }
    else {
        NSLog(@"该设备蓝牙未授权或者不支持蓝牙功能");
    }
}

# pragma mark -- 连接外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"name = %@ uuid = %@", peripheral.name, peripheral.identifier.UUIDString);
    if ([peripheral.identifier.UUIDString isEqualToString:kServerUUID]) {
        // 找到了 连接这个蓝牙设备
        NSLog(@"连接蓝牙设备");
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        [self.centeralManager connectPeripheral:self.peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接上了设备");
    // 已经连接上了设备 停止扫描 去发现服务
//    [self.centeralManager stopScan];
    NSLog(@"peripheral = %@", peripheral.description);
//    self.peripheral.delegate = self;
    [self.peripheral discoverServices:nil];
}

// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备连接失败，设备名：%@ error = %@", peripheral.name, error.description);
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备丢失连接，设备名：%@ error = %@", peripheral.name, error.description);
}

# pragma mark -- 获取外设的服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error) {
        NSLog(@"设备获取服务失败，设备名：%@, error: %@", peripheral.name, error.description);
        return;
    }
    for (CBService *service in peripheral.services) {
//        self.mService = service;
        NSLog(@"设备获取服务成功，服务名：%@，服务UUID：%@，服务数量：%lu",service,service.UUID,peripheral.services.count);
        //外设发现特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
//    for (CBCharacteristic *characteristic in service.characteristics) {
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A23"]]) {
//            // 读取mac地址
//            [self.peripheral readValueForCharacteristic:characteristic];
//        }
//        NSLog(@"characteristic uuid = %@", characteristic.UUID);
//    }
}












/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
