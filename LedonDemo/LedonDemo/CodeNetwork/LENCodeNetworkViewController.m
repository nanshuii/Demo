//
//  LENCodeNetworkViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/8/6.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENCodeNetworkViewController.h"
#import "GCDAsyncUdpSocket.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
//#import "asy"

@interface LENCodeNetworkViewController ()<GCDAsyncUdpSocketDelegate> {
    GCDAsyncUdpSocket *_clientUdpSocket;
    GCDAsyncUdpSocket *_serverUdpSocket;
    int _port;
    BOOL _connectionDone;
    NSString *_ssid;
}

@end

@implementation LENCodeNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.title = @"二维码配网";
    // 获取ip生成一个二维码
    _ssid = [self currentWifiSSID];
    NSLog(@"ssid = %@", _ssid);
    self.ssidLabel.text = _ssid;
    self.contentLabel.numberOfLines = 0;
}

- (IBAction)createCode:(UIButton *)sender {
    NSString *ip = [self currentWifiIp];
    NSLog(@"ip = %@", ip);
    if ([ip isEqualToString:@"error"]) {
        
    } else {
        //            WIFI:T:WPA;S:ipcCameraClock;P:88888888;IP:192.168.199.10;PORT:1020;
        
        //            ssid = [ssid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _port = arc4random() % 100;
        _port += 1024;
        NSString *code = [NSString stringWithFormat:@"WIFI:T:WPA;S:%@;P:%@;IP:%@;PORT:%i;", _ssid, self.passwordTextField.text, ip, _port];
        [self createQRCode:code];
        [self setupServerUdpSocket];
        [self setupClientUdpSocket];
    }
}


- (void)createQRCode:(NSString *)string{
    //创建名为"CIQRCodeGenerator"的CIFilter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //将filter所有属性设置为默认值
    [filter setDefaults];
    
    //将所需尽心转为UTF8的数据，并设置给filter
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //拿到二维码图片，此时的图片不是很清晰，需要二次加工
    CIImage *outPutImage = [filter outputImage];
    UIImage *code = [self getHDImgWithCIImage:outPutImage size:CGSizeMake(240, 240)];
    self.codeImage.image = code;
}


- (UIImage *)getHDImgWithCIImage:(CIImage *)img size:(CGSize)size {
    
    CGRect extent = CGRectIntegral(img.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //清晰的二维码图片
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    return outputImage;
}


# pragma mark -- 获取ssid
- (NSString *)currentWifiSSID {
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }}
    return ssid;
}

# pragma mark -- 获取当前wifi的ip
- (NSString *)currentWifiIp{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - Set up udp socket
- (void)setupClientUdpSocket
{
//    NSError *error = nil;
//
//    if (!_clientUdpSocket) {
//        _clientUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//        [_clientUdpSocket enableBroadcast:YES error:&error];
//    }
//
//    if (![_clientUdpSocket bindToPort:_port error:&error])
//    {
//        NSLog(@"client udp socket bind port error = %@", error.description);
//        return;
//    }
//
//    if (![_clientUdpSocket beginReceiving:&error])
//    {
//        NSLog(@"client udp socket begin receiveing error = %@", error.description);
//        return;
//    }
}

- (void)setupServerUdpSocket {
    if (!_serverUdpSocket) {
        _serverUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_serverUdpSocket enableBroadcast:YES error:nil];
    }
    
    NSError *error = nil;
    
    if (![_serverUdpSocket bindToPort:_port error:&error])
    {
        return;
    }
    
    if (![_serverUdpSocket beginReceiving:&error])
    {
        return;
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    if (_connectionDone) {
        return;
    }
    NSLog(@"data length = %li", data.length);
    // 设备连接WIFI成功后会像10000端口发送至少20个UDP广播包所附带的随机数
    if (data != nil && data.length > 20) {
        _connectionDone = true;
        UInt8 *bytes = (UInt8 *) [data bytes];
        NSLog(@"连接成功");
        NSLog(@"smart link 连接成功 length = %li byte[0] = %i", data.length, bytes[0]);
        NSRange range1 = NSMakeRange(1, 16);
        NSData *data1 = [data subdataWithRange:range1];
        NSString *str1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSLog(@"data1 = %@ str1 = %@", data1.description, str1);
        NSRange range2 = NSMakeRange(17, 8);
        NSData *data2 = [data subdataWithRange:range2];
        char *no = [data2 bytes];
        NSMutableString *hexString = [NSMutableString string];
        for (int i=0; i<8 ; i++) {
            NSLog(@"0x%02x ",no[i]&0x000000ff);
            [hexString appendFormat:@"%02x",no[i]&0x000000ff];
            NSLog(@"device id = %@", hexString);
        }
        NSLog(@"******\r\n\r\n");
        NSLog(@"获取完成之后的deviceId = %@", hexString);
        NSRange range3 = NSMakeRange(25, 20);
        NSData *data3 = [data subdataWithRange:range3];
        NSString *str3 = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
        NSLog(@"data3 = %@ str3 = %@", data3.description, str3);
        
        self.contentLabel.text = [NSString stringWithFormat:@"ip:%@", str1];
        self.contentLabel1.text = [NSString stringWithFormat:@"deviceNo:%@", hexString];
        self.contentLabel2.text = [NSString stringWithFormat:@"uid:%@", str3];
        
    }
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
