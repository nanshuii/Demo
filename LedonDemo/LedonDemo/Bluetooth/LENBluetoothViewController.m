//
//  LENBluetoothViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENBluetoothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define mBLEName @"KeyBox"

@interface LENBluetoothViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *mCentral; // 手机设备

@property (nonatomic, strong) CBPeripheral *mPeripheral; // 外设设备

@property (nonatomic, strong) CBCharacteristic *mCharacteristic; // 特征

@property (nonatomic, strong) CBService *mService; // 服务

@property (nonatomic, strong) CBDescriptor *mDescriptor; // 描述

@end

@implementation LENBluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
    [self mCentral];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self mCenterDisConnect];
}

- (void)setUpUI{
    self.title = @"蓝牙连接";
    
}

# pragma mark -- 初始化设备
- (CBCentralManager *)mCentral{
    if (!_mCentral) {
        _mCentral = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
    }
    return _mCentral;
}

# pragma mark -- 断开连接
- (void)mCenterDisConnect{
    if (_mCentral) {
        [self.mCentral stopScan]; // 停止扫描
        if (_mPeripheral && _mPeripheral.state == CBPeripheralStateConnecting) {
            [self.mCentral cancelPeripheralConnection:self.mPeripheral]; // 停止连接
        }
    }
}

# pragma mark -- 扫描外设
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    // CBCentralManager初始化后自动触发
    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@"CBManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@"CBManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"CBManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"CBManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"CBManagerStatePoweredOff");
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"CBManagerStatePoweredOn");
            //搜索外设 这个应该是优化点
            [self.mCentral scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                                  options:nil]; // dict,条件
        }
            break;
        default:
            break;
    }
}

# pragma mark -- 连接外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
//    NSLog(@"搜索到设备名：%@，设备ID：%@，信号强度 = %i",peripheral.name,peripheral.identifier, [RSSI integerValue]);
    
    NSLog(@"name = %@ data = %@", peripheral.name ,advertisementData.description);
    NSData *data = [advertisementData valueForKey:@"kCBAdvDataManufacturerData"];
    if (data && data.length == 13) {
        Byte *bytes = (Byte *)[data bytes];
//        for (int i = 0; i < [data length]; i++) {
//            NSLog(@"byte = %d %x", bytes[i], bytes[i]);
//        }
        NSString *company_id = [NSString stringWithFormat:@"0x%02x%02x", bytes[1], bytes[0]]; // 前两位 厂商ID
        NSString *type = [NSString stringWithFormat:@"0x%02x%02x%02x%02x", bytes[5], bytes[4], bytes[3], bytes[2]]; // 后四位 设备类型
        NSString *mac = [NSString stringWithFormat:@"0x%02x%02x%02x%02x%02x%02x", bytes[11], bytes[10], bytes[9], bytes[8], bytes[7], bytes[6]]; // 后六位 mac地址
        NSString *bind = [NSString stringWithFormat:@"%x", bytes[12]]; // 绑定标识 0 绑定 1 出厂状态
        NSLog(@"company_id = %@ type = %@ mac = %@ bind = %@", company_id, type, mac, bind);
    }
    
    
    
    if ([peripheral.name isEqualToString:mBLEName]) {
        self.mPeripheral = peripheral;
        self.mPeripheral.delegate = self;
        [self.mCentral connectPeripheral:peripheral options:nil];
    }
}

# pragma mark -- 获取服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"设备连接成功，设备名：%@", peripheral.name);
    // 外设发现服务,传nil代表不过滤
    [self.mCentral stopScan];
    [self.mPeripheral discoverServices:nil];
}

// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备连接失败，设备名：%@", peripheral.name);
    // 连接失败
    NSLog(@"重连");
    [self.mCentral scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                          options:nil]; // dict,条件
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备丢失连接，设备名：%@", peripheral.name);
    // 重连
    NSLog(@"重连");
    [self.mCentral scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                          options:nil]; // dict,条件
}

# pragma mark -- 获取外设的服务后调用的方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error) {
        NSLog(@"设备获取服务失败，设备名：%@, error: %@", peripheral.name, error.description);
        return;
    }
    for (CBService *service in peripheral.services) {
        self.mService = service;
        NSLog(@"设备获取服务成功，服务名：%@，服务UUID：%@，服务数量：%lu",service,service.UUID,peripheral.services.count);
        //外设发现特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//从服务中发现外设特征的时候调用的代理方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if(error){
        NSLog(@"设备获取特征失败，设备名：%@", peripheral.name);
        return;
    }
    /**
     CBCharacteristicPropertyRead                                                    = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                    = 0x04,
     CBCharacteristicPropertyWrite                                                   = 0x08,
     CBCharacteristicPropertyNotify                                                  = 0x10,
     */
    for (CBCharacteristic *cha in service.characteristics) {
        NSLog(@"设备获取特征成功，服务名：%@，uuid: %@ 特征值名：%@，特征UUID：%@，特征数量：%lu",service,service.UUID, cha,cha.UUID,service.characteristics.count);
        //获取特征对应的描述 会回调didDiscoverDescriptorsForCharacteristic
        [peripheral discoverDescriptorsForCharacteristic:cha];
        //获取特征的值 会回调didUpdateValueForCharacteristic
        [peripheral readValueForCharacteristic:cha];
    }
    if(nil != self.mCharacteristic){
        //打开外设的通知，否则无法接受数据
        [peripheral setNotifyValue:YES forCharacteristic:self.mCharacteristic];
    }
}

//更新特征值的时候调用，可以理解为获取蓝牙发回的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding];
    NSLog(@"特征名：%@，UUID: %@, 特征值：%@",characteristic, characteristic.UUID, value);
    // Manufacturer Name String 制造商名字 ShangHai JuYi Technology Co., Ltd.
    // Model Number String 模型名字 JYGLASS
    // Hardware Revision String 硬件版本 1.0.0
    // Firmwave Revision String 固件版本 sd=0x0098, app=255.15.15, bl=255.15.15
    
}

//通知状态改变时调用
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if(error){
        NSLog(@"特征名：%@，改变通知状态失败",characteristic);
    }
    NSLog(@"特征名：%@，改变了通知状态",characteristic);
}

//发现外设的特征的描述数组
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if(error){
        NSLog(@"设备获取描述失败，设备名：%@", peripheral.name);
        return;
    }
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        self.mDescriptor = descriptor;
        [peripheral readValueForDescriptor:descriptor];
        NSLog(@"设备获取描述成功，描述名：%@",descriptor);
    }
}

//发送数据
-(void)sendDataToBLE:(NSString *)data{
    NSData* myData = [data dataUsingEncoding:NSUTF8StringEncoding];
    [self.mPeripheral writeValue:myData // 写入的数据
               forCharacteristic:self.mCharacteristic // 写给哪个特征
                            type:CBCharacteristicWriteWithResponse];// 通过此响应记录是否成功写入
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"数据发送成功");
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
