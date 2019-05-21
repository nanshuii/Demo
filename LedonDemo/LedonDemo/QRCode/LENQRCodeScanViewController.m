//
//  LENQRCodeScanViewController.m
//  LedonDemo
//
//  Created by 林南水 on 2019/5/21.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "LENQRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LENQRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice * device; //捕获设备，默认后置摄像头
@property (strong, nonatomic) AVCaptureDeviceInput * input; //输入设备
@property (strong, nonatomic) AVCaptureMetadataOutput * output;//输出设备，需要指定他的输出类型及扫描范围
@property (strong, nonatomic) AVCaptureSession * session; //AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * previewLayer;//展示捕获图像的图层，是CALayer的子类

@end

@implementation LENQRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.session startRunning];
}

- (void)setUpUI{
    self.title = @"扫一扫";
    self.scanView.layer.borderColor = [UIColor greenColor].CGColor;
    self.scanView.layer.borderWidth = 1;
    [self configBasicDevice];
}

- (void)configBasicDevice{
    //默认使用后置摄像头进行扫描,使用AVMediaTypeVideo表示视频
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //设备输入 初始化
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    //设备输出 初始化，并设置代理和回调，当设备扫描到数据时通过该代理输出队列，一般输出队列都设置为主队列，也是设置了回调方法执行所在的队列环境
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //会话 初始化，通过 会话 连接设备的 输入 输出，并设置采样质量为 高
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    //会话添加设备的 输入 输出，建立连接
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    //指定设备的识别类型 这里只指定二维码识别这一种类型 AVMetadataObjectTypeQRCode
    //指定识别类型这一步一定要在输出添加到会话之后，否则设备的课识别类型会为空，程序会出现崩溃
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //设置扫描信息的识别区域，本文设置正中央的一块正方形区域，该区域宽度是scanRegion_W
    //这里考虑了导航栏的高度，所以计算有点麻烦，识别区域越小识别效率越高，所以不设置整个屏幕
    //    CGFloat navH = self.navigationController.navigationBar.bounds.size.height;
    //    CGFloat viewH = ZYAppHeight - navH;
    //    CGFloat scanViewH = self.scanRegion_W;
    //    [self.output setRectOfInterest:CGRectMake((ZYAppWidth-scanViewH)/(2*ZYAppWidth), (viewH-scanViewH)/(2*viewH), scanViewH/ZYAppWidth, scanViewH/viewH)];
    [self.output setRectOfInterest:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //预览层 初始化，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    //预览层的区域设置为整个屏幕，这样可以方便我们进行移动二维码到扫描区域,在上面我们已经对我们的扫描区域进行了相应的设置
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    //    self.previewLayer.frame = CGRectMake(0, 0, ZYAppWidth, ZYAppHeight);
    self.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self.session stopRunning];   //停止扫描
    if ([metadataObjects count] >= 1) {
        //数组中包含的都是AVMetadataMachineReadableCodeObject 类型的对象，该对象中包含解码后的数据
        AVMetadataMachineReadableCodeObject *qrObject = [metadataObjects lastObject];
        //拿到扫描内容在这里进行个性化处理
        NSString *result = qrObject.stringValue;
        //解析数据进行处理并实现相应的逻辑
        //代码省略
        NSLog(@"扫码结果 = %@", result);
    }
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
